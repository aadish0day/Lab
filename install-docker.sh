#!/usr/bin/env bash
# ============================================================================
# install-docker.sh  —  Docker + Lazydocker setup for Debian / Ubuntu only
# ============================================================================
# One-command installer for Debian, Ubuntu, Linux Mint, Pop!_OS, Kali, etc.
#
# Usage:
#   bash install-docker.sh
#   bash install-docker.sh --with-lazydocker
# ============================================================================
set -euo pipefail

WITH_LAZYDOCKER=1   # default: install lazydocker too
for arg in "$@"; do
    case "$arg" in
        --docker-only) WITH_LAZYDOCKER=0 ;;
        -h|--help)
            echo "Usage: $0 [--docker-only]"
            echo "  (default)          Install Docker + Lazydocker"
            echo "  --docker-only      Install Docker only (skip Lazydocker)"
            exit 0
            ;;
    esac
done

if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
    RUN_USER="${SUDO_USER:-$USER}"
else
    SUDO="sudo"
    RUN_USER="$USER"
fi

log()   { printf '\e[1;34m[INFO]\e[0m %s\n' "$*"; }
warn()  { printf '\e[1;33m[WARN]\e[0m %s\n' "$*" >&2; }
err()   { printf '\e[1;31m[ERROR]\e[0m %s\n' "$*" >&2; }
die()   { err "$*"; exit 1; }

# ----------------------------------------------------------------------------
# Confirm Debian/Ubuntu family
# ----------------------------------------------------------------------------
if [ ! -f /etc/os-release ]; then
    die "This script is for Debian/Ubuntu only."
fi

. /etc/os-release
ID="${ID:-}"
ID_LIKE="${ID_LIKE:-}"
CODENAME="${UBUNTU_CODENAME:-${DEBIAN_CODENAME:-${VERSION_CODENAME:-}}}"

if [ "$ID" != "ubuntu" ] && [ "$ID" != "debian" ] && \
   [[ ! " $ID_LIKE " == *" ubuntu "* ]] && [[ ! " $ID_LIKE " == *" debian "* ]]; then
    die "Unsupported distro: $ID ($ID_LIKE). This script is Debian/Ubuntu only."
fi

log "Detected distro: $ID $VERSION_ID ($ID_LIKE) codename=$CODENAME"

# Map to the Docker repo distro (ubuntu vs debian)
if [ "$ID" = "ubuntu" ] || [[ " $ID_LIKE " == *" ubuntu "* ]]; then
    REPO_DISTRO="ubuntu"
else
    REPO_DISTRO="debian"
fi

# Kali uses the Debian "bookworm" Docker repo
if [ "$ID" = "kali" ]; then
    CODENAME="bookworm"
    REPO_DISTRO="debian"
fi

ARCH="$(dpkg --print-architecture)"

# ----------------------------------------------------------------------------
# Install Docker CE
# ----------------------------------------------------------------------------
log "Installing Docker CE on $ID ($CODENAME, $ARCH)..."

# Remove conflicting distro packages
conflicts=(docker.io docker-doc docker-compose podman-docker containerd runc)
installed_conflicts=()
for p in "${conflicts[@]}"; do
    dpkg-query -W -f='${Status}' "$p" 2>/dev/null | grep -q "install ok installed" && installed_conflicts+=("$p")
done
if [ "${#installed_conflicts[@]}" -gt 0 ]; then
    log "Removing conflicting packages: ${installed_conflicts[*]}"
    $SUDO apt-get remove -y "${installed_conflicts[@]}"
fi

# Add Docker's official GPG key
$SUDO apt-get update -qq
$SUDO apt-get install -y ca-certificates curl gnupg

$SUDO install -m 0755 -d /etc/apt/keyrings
$SUDO curl -fsSL https://download.docker.com/linux/$REPO_DISTRO/gpg | $SUDO gpg --dearmor -o /etc/apt/keyrings/docker.gpg
$SUDO chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources
echo "deb [arch=$ARCH signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$REPO_DISTRO $CODENAME stable" \
    | $SUDO tee /etc/apt/sources.list.d/docker.list >/dev/null

$SUDO apt-get update -qq
$SUDO apt-get install -y docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Enable service + docker group
log "Enabling and starting Docker service..."
if [ -d /run/systemd/system ]; then
    $SUDO systemctl enable --now docker.service 2>/dev/null || \
        warn "Could not enable docker.service via systemd."
else
    warn "systemd not detected; start Docker manually (e.g. 'sudo dockerd')."
fi

log "Adding user '$RUN_USER' to the docker group..."
if getent group docker &>/dev/null; then
    $SUDO usermod -aG docker "$RUN_USER"
else
    warn "docker group not found."
fi

log "=============================================="
log "Docker installed successfully!"
log "=============================================="
log " 1. Log out and back in (or run: newgrp docker)"
log " 2. Test it: docker run hello-world"

# ----------------------------------------------------------------------------
# Lazydocker (optional)
# ----------------------------------------------------------------------------
if [ "$WITH_LAZYDOCKER" -eq 1 ]; then
    log "Installing Lazydocker..."
    if command -v lazydocker &>/dev/null; then
        log "lazydocker already installed."
    else
        RAW_ARCH="$(uname -m)"
        case "$RAW_ARCH" in
            x86_64|amd64) LAZY_ARCH="x86_64" ;;
            aarch64|arm64) LAZY_ARCH="arm64" ;;
            armv7*) LAZY_ARCH="armv7" ;;
            *) die "Unsupported architecture for lazydocker: $RAW_ARCH" ;;
        esac

        TAG="$(curl -fsSL -H 'Accept: application/vnd.github+json' \
            "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" 2>/dev/null \
            | grep -oP '"tag_name":\s*"\K[^"]+' || true)"
        [ -z "$TAG" ] && TAG="v0.24.1"
        VERSION="${TAG#v}"

        TEMP_DIR="$(mktemp -d)"
        trap 'rm -rf "$TEMP_DIR"' EXIT

        ARCHIVE="lazydocker_${VERSION}_Linux_${LAZY_ARCH}.tar.gz"
        URL="https://github.com/jesseduffield/lazydocker/releases/download/$TAG/$ARCHIVE"

        log "Downloading $ARCHIVE..."
        curl -fSL -o "$TEMP_DIR/$ARCHIVE" "$URL"
        tar -xzf "$TEMP_DIR/$ARCHIVE" -C "$TEMP_DIR" lazydocker
        $SUDO install -m 0755 "$TEMP_DIR/lazydocker" /usr/local/bin/lazydocker
    fi

    for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
        touch "$rc"
        ALIAS_LINE="alias lzd='lazydocker'"
        if ! grep -qxF -- "$ALIAS_LINE" "$rc"; then
            printf '\n# Lazydocker\n%s\n' "$ALIAS_LINE" >> "$rc"
        fi
    done

    log "Lazydocker installed. Run: lazydocker  (or alias: lzd)"
    warn "You must be in the docker group (log out/in) to use lazydocker without sudo."
fi

log "All done."
