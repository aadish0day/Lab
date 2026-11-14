#!/usr/bin/env bash
#
# vpn-download.sh - Safe video downloader wrapped in Proton VPN
#

set -eo pipefail

DOWNLOAD_DIR="${HOME}/Downloads/VPN_Videos"
SPECIFIED_COUNTRY=""
AUTO_DISCONNECT=false
WE_STARTED_VPN=false
QUALITY="720" # Default 720p: Best balance of high quality and smaller file size
PROXY_URL=""
ALLOW_PLAYLIST=false
MAX_DOWNLOADS=""
MIN_DURATION="${MIN_DURATION:-}" # Minimum duration in seconds or mm:ss (e.g. 180 or 3:00)
NO_PROXY=false
NO_ARIA2C=false
RETRIES="${YT_DLP_RETRIES:-10}"                   # Whole-URL retries (covers expired m3u8/410 errors)
FRAGMENT_RETRIES="${YT_DLP_FRAGMENT_RETRIES:-10}" # Per-HLS-fragment retries
CONCURRENT_FRAGMENTS="${YT_DLP_CONCURRENT_FRAGMENTS:-8}"
DEFAULT_PROXY="http://127.0.0.1:8888" # Gluetun HTTP proxy (see gluetun/docker-compose.yml)
# Downloads abort if the proxy exit node is inside this country code (override env).
PROTECTED_COUNTRY="${PROTECTED_COUNTRY:-IN}"

# Ensure PhantomJS compatibility with modern OpenSSL
export OPENSSL_CONF=/dev/null

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

mkdir -p "$DOWNLOAD_DIR"

usage() {
    local exit_code="${1:-1}"
    echo -e "${BLUE}=== ProtonVPN Safe Video Downloader ===${NC}"
    echo "Usage: $0 [options] <URL | -f urls.txt>"
    echo ""
    echo "Options:"
    echo "  -f, --file FILE        Read URLs line-by-line from a text file"
    echo "  -q, --quality HEIGHT   Max video resolution (default: 720 for smaller size + HD quality; or 1080, 480)"
    echo "  -c, --country CODE     Preferred country code (Paid plans only, e.g. US, NL)"
    echo "  -x, --proxy URL        Route downloads through this HTTP proxy (default Gluetun: $DEFAULT_PROXY)"
    echo "  -P, --no-proxy         Skip proxy detection, use the protonvpn CLI path only"
    echo "  -A, --no-aria2c        Disable aria2c external downloader (default: use it if installed)"
    echo "  -d, --disconnect       Always disconnect VPN when downloads finish"
    echo "  -k, --keep-vpn         Keep VPN connected even if the script started it"
    echo "  -p, --playlist, --all  Download entire channel, playlist, or actor page"
    echo "  -m, --max-downloads N  Stop after downloading N videos"
    echo "  --min-duration TIME    Skip videos shorter than TIME (e.g., 180, 240, 3m, 4m)"
    echo "  -o, --output DIR       Save directory (default: $DOWNLOAD_DIR)"
    echo "  -h, --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 \"https://example.com/watch?v=...\""
    echo "  $0 -f links.txt -d"
    echo "  $0 -q 1080 -f links.txt -d"
    exit "$exit_code"
}

# Parse command line flags
INPUT_FILE=""
URL=""
KEEP_VPN=false

while [[ $# -gt 0 ]]; do
    case "$1" in
    -f | --file)
        INPUT_FILE="$2"
        shift 2
        ;;
    -q | --quality)
        QUALITY="$2"
        shift 2
        ;;
    -c | --country)
        SPECIFIED_COUNTRY="$2"
        shift 2
        ;;
    -x | --proxy)
        PROXY_URL="$2"
        shift 2
        ;;
    -P | --no-proxy)
        NO_PROXY=true
        shift
        ;;
    -A | --no-aria2c)
        NO_ARIA2C=true
        shift
        ;;
    -d | --disconnect)
        AUTO_DISCONNECT=true
        shift
        ;;
    -k | --keep-vpn)
        KEEP_VPN=true
        shift
        ;;
    -p | --playlist | --all)
        ALLOW_PLAYLIST=true
        shift
        ;;
    -m | --max-downloads)
        MAX_DOWNLOADS="$2"
        shift 2
        ;;
    --min-duration)
        MIN_DURATION="$2"
        shift 2
        ;;
    -o | --output)
        DOWNLOAD_DIR="$2"
        shift 2
        ;;
    -h | --help)
        usage 0
        ;;
    *)
        URL="$1"
        shift
        ;;
    esac
done

if [[ -z "$URL" && -z "$INPUT_FILE" ]]; then
    echo -e "${RED}[!] Error: No URL or input file provided.${NC}"
    usage
fi

# Resolve the Gluetun HTTP proxy path (see gluetun/docker-compose.yml).
# Priority: -x/--proxy flag > auto-detect $DEFAULT_PROXY > protonvpn CLI path.
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
GLUETUN_DIR="${GLUETUN_DIR:-$SCRIPT_DIR/gluetun}"
USING_GLUETUN_STACK=false # true when downloads run through the ./gluetun compose stack

resolve_proxy() {
    if [[ "$NO_PROXY" = true || -n "$PROXY_URL" ]]; then
        return
    fi
    if curl -s --max-time 5 -x "$DEFAULT_PROXY" "https://ipinfo.io" >/dev/null 2>&1; then
        PROXY_URL="$DEFAULT_PROXY"
        USING_GLUETUN_STACK=true
        echo -e "${BLUE}[*] Detected Gluetun proxy on $DEFAULT_PROXY, routing downloads through it.${NC}"
        return
    fi
    # Not running: auto-start the Gluetun gateway instead of falling back to
    # the(protonvpn CLI, which is dead on this host).
    if [[ -f "$GLUETUN_DIR/docker-compose.yml" ]]; then
        echo -e "${YELLOW}[*] Gluetun gateway not responding. Starting it automatically...${NC}"
        (cd "$GLUETUN_DIR" && docker compose up -d) || {
            echo -e "${RED}[!] Failed to start the Gluetun gateway.${NC}"
            return
        }
        echo -e "${YELLOW}[*] Waiting for the VPN tunnel to come up (max 45s)...${NC}"
        for i in $(seq 1 15); do
            sleep 3
            if curl -s --max-time 5 -x "$DEFAULT_PROXY" "https://ipinfo.io" >/dev/null 2>&1; then
                PROXY_URL="$DEFAULT_PROXY"
                USING_GLUETUN_STACK=true
                echo -e "${GREEN}[+] Gluetun gateway is up.${NC}"
                return
            fi
        done
        echo -e "${RED}[!] Gluetun gateway did not come up in time.${NC}"
    fi
}

preflight_proxy() {
    echo -e "${YELLOW}[*] Checking VPN proxy tunnel...${NC}"
    local exit_ip="" exit_country=""
    local info
    info=$(curl -s --max-time 20 -x "$PROXY_URL" "https://ipinfo.io/json" || true)
    exit_ip=$(echo "$info" | python3 -c 'import sys, json; print(json.load(sys.stdin).get("ip", ""))' 2>/dev/null || true)
    exit_country=$(echo "$info" | python3 -c 'import sys, json; print(json.load(sys.stdin).get("country", ""))' 2>/dev/null || true)
    # Fallback: ipinfo.io rate-limits shared datacenter IPs (HTTP 429) and
    # returns a body with no country field. Check a second, independent
    # provider before declaring the tunnel broken.
    if [[ -z "$exit_country" ]]; then
        echo -e "${YELLOW}[*] ipinfo.io did not answer with country info (rate limit?), trying fallback providers...${NC}"
        exit_country=$(curl -s --max-time 20 -x "$PROXY_URL" "https://ifconfig.co/country" || true)
        [[ -z "$exit_ip" ]] && exit_ip=$(curl -s --max-time 20 -x "$PROXY_URL" "https://api.ipify.org" || true)
    fi
    if [[ -z "$exit_country" ]]; then
        echo -e "${RED}[!] Proxy is unreachable or not a working HTTP proxy: $PROXY_URL${NC}"
        echo -e "${RED}    Try starting the gateway with: (cd $GLUETUN_DIR && docker compose up -d)${NC}"
        exit 1
    fi
    if [[ "$exit_country" == "$PROTECTED_COUNTRY" ]]; then
        echo -e "${RED}[!] Proxy exit is in your own country ($exit_country). Aborting to protect your IP.${NC}"
        exit 1
    fi
    echo -e "${GREEN}[+] Proxy tunnel OK - exit node $exit_ip ($exit_country).${NC}"
}

check_vpn() {
    echo -e "${YELLOW}[*] Checking Proton VPN status...${NC}"
    local status
    status=$(PYTHONWARNINGS="ignore" protonvpn status 2>/dev/null || true)

    if echo "$status" | grep -iq "Status: Connected"; then
        echo -e "${GREEN}[+] VPN is already connected.${NC}"
    else
        echo -e "${YELLOW}[!] VPN is disconnected. Starting VPN automatically...${NC}"
        WE_STARTED_VPN=true

        if [[ -n "$SPECIFIED_COUNTRY" ]]; then
            PYTHONWARNINGS="ignore" protonvpn connect --country "$SPECIFIED_COUNTRY" || {
                echo -e "${RED}[!] Failed to connect to $SPECIFIED_COUNTRY. Trying fastest free server...${NC}"
                PYTHONWARNINGS="ignore" protonvpn connect || {
                    echo -e "${RED}[!] Failed to connect to Proton VPN. Aborting to protect your IP.${NC}"
                    exit 1
                }
            }
        else
            PYTHONWARNINGS="ignore" protonvpn connect || {
                echo -e "${RED}[!] Failed to connect to Proton VPN. Aborting to protect your IP.${NC}"
                exit 1
            }
        fi
        echo -e "${GREEN}[+] VPN connected successfully!${NC}"
    fi
}

cleanup() {
    # Gluetun path: -d tears down the whole vpn-gateway container stack.
    if [[ "$USING_GLUETUN_STACK" = true && "$AUTO_DISCONNECT" = true ]]; then
        if [[ -n "$(docker ps -q --filter name=gluetun)" ]]; then
            echo -e "${YELLOW}[*] Stopping Gluetun VPN gateway (docker compose down)...${NC}"
            if (cd "$GLUETUN_DIR" && docker compose down); then
                echo -e "${GREEN}[+] Gluetun VPN gateway stopped.${NC}"
            else
                echo -e "${RED}[!] Failed to stop Gluetun stack; stop it manually: (cd $GLUETUN_DIR && docker compose down)${NC}"
            fi
        else
            echo -e "${BLUE}[*] Gluetun VPN gateway not running; nothing to stop.${NC}"
        fi
        return
    fi
    # ProtonVPN CLI path (-P/--no-proxy): disconnect the host VPN session.
    if [ "$AUTO_DISCONNECT" = true ] || ([ "$WE_STARTED_VPN" = true ] && [ "$KEEP_VPN" = false ]); then
        echo -e "${YELLOW}[*] Disconnecting Proton VPN...${NC}"
        PYTHONWARNINGS="ignore" protonvpn disconnect 2>/dev/null || true
        echo -e "${GREEN}[+] VPN disconnected.${NC}"
    fi
}
trap cleanup EXIT

# 1. Route through Gluetun proxy when available, otherwise start Proton VPN
resolve_proxy
# An explicit -x of the Gluetun address counts as using the stack too,
# so -d can tear it down.
if [[ "$PROXY_URL" == "$DEFAULT_PROXY" ]]; then
    USING_GLUETUN_STACK=true
fi
if [[ -n "$PROXY_URL" ]]; then
    preflight_proxy
else
    check_vpn
fi

# 3. Renumber: Run yt-dlp (playlist etc.)
echo -e "${GREEN}[+] Target Quality: ${QUALITY}p (optimized size)${NC}"
echo -e "${GREEN}[+] Saving videos to: ${DOWNLOAD_DIR}${NC}"

# Format selector: Prioritize requested max height (e.g. 720p), fallback to best available
FORMAT_STR="bestvideo[height<=${QUALITY}]+bestaudio/best[height<=${QUALITY}]/best"

# Fast downloader: prefer aria2c for direct (mp4) downloads when installed.
# It splits each file into multiple parallel connections (-x 8), which is a
# big speedup over yt-dlp's single-stream native downloader.
# Aria2c must reach the exit node itself, so we hand it the proxy explicitly.
pick_downloader_args() {
    if [[ "$NO_ARIA2C" = true ]] || ! command -v aria2c >/dev/null 2>&1; then
        return
    fi
    local aria_args="-x 8 -s 8 -k 2M -c"
    if [[ -n "$PROXY_URL" ]]; then
        aria_args+=" --all-proxy=$PROXY_URL"
    fi
    YTDLP_ARGS+=(
        --downloader aria2c
        --downloader-args "aria2c:${aria_args}"
    )
    echo -e "${BLUE}[*] Using aria2c for faster parallel downloads (-x 8).${NC}"
}

YTDLP_ARGS=(
    --continue
    --windows-filenames
    --retries "$RETRIES"
    --fragment-retries "$FRAGMENT_RETRIES"
    --concurrent-fragments "$CONCURRENT_FRAGMENTS"
    --socket-timeout 30
    -o "${DOWNLOAD_DIR}/%(title)s [%(id)s].%(ext)s"
    --format "$FORMAT_STR"
)

if [[ "$ALLOW_PLAYLIST" = true ]]; then
    YTDLP_ARGS+=(--yes-playlist)
    if [[ -n "$MAX_DOWNLOADS" ]]; then
        YTDLP_ARGS+=(--max-downloads "$MAX_DOWNLOADS")
    fi
else
    YTDLP_ARGS+=(--no-playlist)
fi

if [[ -n "$PROXY_URL" ]]; then
    YTDLP_ARGS+=(--proxy "$PROXY_URL")
fi

if [[ -n "$MIN_DURATION" ]]; then
    # Convert formats like 3m, 4m, 3:00 to seconds if needed, or pass directly
    MIN_SECS="$MIN_DURATION"
    if [[ "$MIN_DURATION" =~ ^([0-9]+)m$ ]]; then
        MIN_SECS=$((${BASH_REMATCH[1]} * 60))
    elif [[ "$MIN_DURATION" =~ ^([0-9]+):([0-9]+)$ ]]; then
        MIN_SECS=$((10#${BASH_REMATCH[1]} * 60 + 10#${BASH_REMATCH[2]}))
    fi
    YTDLP_ARGS+=(--match-filter "duration >=? ${MIN_SECS}")
    echo -e "${BLUE}[*] Filtering videos: minimum duration ${MIN_SECS}s (skipping shorter clips).${NC}"
fi

pick_downloader_args

if [[ -n "$INPUT_FILE" ]]; then
    if [[ ! -f "$INPUT_FILE" ]]; then
        echo -e "${RED}[!] Input file '$INPUT_FILE' not found!${NC}"
        exit 1
    fi
    yt-dlp "${YTDLP_ARGS[@]}" -a "$INPUT_FILE"
else
    yt-dlp "${YTDLP_ARGS[@]}" "$URL"
fi

echo -e "${GREEN}[✔] All downloads finished successfully!${NC}"
