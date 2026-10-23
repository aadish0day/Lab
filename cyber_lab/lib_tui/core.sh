#!/usr/bin/env bash
# ==============================================================================
# CyberLab Core Operations & Lab Engine
# lib_tui/core.sh
# ==============================================================================

# Determine base paths relative to lib_tui location
CYBERLAB_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CYBERLAB_ROOT="$(cd "${CYBERLAB_LIB_DIR}/.." && pwd)"
CYBERLAB_SCRIPT="${CYBERLAB_ROOT}/lab"

# Define global associative arrays and categories
declare -gA LABS=()
declare -gA LAB_CATEGORY=()
declare -gA PATH_TO_KEY=()
declare -gA CATEGORY_LABS=()
declare -ga ALL_LAB_KEYS=()

# Canonical Category Definitions
declare -ga CATEGORIES=(
    "01_ethical_hacking"
    "02_web_pentesting"
    "03_network_security"
    "04_network_pentesting"
    "05_exploit_writing"
    "06_cloud_k8s_ai"
    "07_devsecops"
    "08_oauth_iot"
    "09_tools"
    "10_vulhub_skf"
)

declare -gA CATEGORY_TITLES=(
    ["01_ethical_hacking"]="Ethical Hacking & Scanning"
    ["02_web_pentesting"]="Web Pentesting & OWASP"
    ["03_network_security"]="Network Security"
    ["04_network_pentesting"]="Network Pentesting & Middleware"
    ["05_exploit_writing"]="Exploit Writing & Binary"
    ["06_cloud_k8s_ai"]="Cloud, Kubernetes & LLM/AI Security"
    ["07_devsecops"]="DevSecOps & CI/CD Pipeline"
    ["08_oauth_iot"]="OAuth, API Gateway & IoT/SCADA"
    ["09_tools"]="Dedicated Tooling Suite (Sliver, Suricata, Snort, Zeek, DefectDojo, etc.)"
    ["10_vulhub_skf"]="Vulhub & OWASP-SKF Practice Targets"
)

# ------------------------------------------------------------------------------
# 1. Lab Catalog Loading & Metadata Helpers
# ------------------------------------------------------------------------------

# shellcheck disable=SC2120
# Parse and load all lab definitions from lab script
core_load_labs() {
    local lab_file="${1:-$CYBERLAB_SCRIPT}"
    local force="${2:-0}"
    if [[ "${1:-}" == "--force" ]]; then
        lab_file="$CYBERLAB_SCRIPT"
        force=1
    fi

    # Return in-memory data if already loaded
    if [[ ${#LABS[@]} -gt 0 && "$force" -eq 0 ]]; then
        return 0
    fi

    if [[ ! -f "$lab_file" ]]; then
        echo "Error: Lab definition file not found: $lab_file" >&2
        return 1
    fi

    # Persistent cache directory (survives reboots in ~/.cache/cyberlab)
    local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/cyberlab"
    mkdir -p "$cache_dir" 2>/dev/null || cache_dir="${TMPDIR:-/tmp}"
    local cache_file="${cache_dir}/catalog_cache.bash"

    # Fast-path: Load from precompiled disk cache if newer than lab file
    if [[ "$force" -eq 0 && -f "$cache_file" && "$cache_file" -nt "$lab_file" ]]; then
        # shellcheck disable=SC1090
        if source "$cache_file" 2>/dev/null && [[ ${#LABS[@]} -gt 0 ]]; then
            return 0
        fi
    fi

    # Reset internal stores
    LABS=()
    LAB_CATEGORY=()
    PATH_TO_KEY=()
    CATEGORY_LABS=()
    ALL_LAB_KEYS=()

    local current_sec=""
    local line key val item_cat path desc port abs_path

    while IFS= read -r line || [[ -n "$line" ]]; do
        # Section header tracking
        if [[ "$line" == *"# Classes - 01 Ethical Hacking"* ]]; then
            current_sec="01_ethical_hacking"
        elif [[ "$line" == *"# Classes - 02 Web Pentesting"* ]]; then
            current_sec="02_web_pentesting"
        elif [[ "$line" == *"# Classes - 03 Network Security"* ]]; then
            current_sec="03_network_security"
        elif [[ "$line" == *"# Classes - 04 Network Pentesting"* ]]; then
            current_sec="04_network_pentesting"
        elif [[ "$line" == *"# Classes - 05 Exploit Writing"* ]]; then
            current_sec="05_exploit_writing"
        elif [[ "$line" == *"# Real World Industry Labs"* ]]; then
            current_sec="rwil"
        elif [[ "$line" == *"# Tools -"* || "$line" == *"# Dedicated Tooling Suite"* ]]; then
            current_sec="09_tools"
        elif [[ "$line" == *"# Batch Vulhub"* || "$line" == *"# Batch 13"* || "$line" == *"# Batch 14"* ]]; then
            current_sec="10_vulhub_skf"
        elif [[ "$line" =~ ^[[:space:]]*LABS\[\"([^\"]+)\"\]=\"([^\"]+)\" ]]; then
            key="${BASH_REMATCH[1]}"
            val="${BASH_REMATCH[2]}"
            LABS["$key"]="$val"
            ALL_LAB_KEYS+=("$key")

            IFS="|" read -r path desc port <<<"$val"

            # Determine category
            item_cat="$current_sec"
            if [[ "$item_cat" == "rwil" ]]; then
                if [[ "$path" == *"01_llm_ai_security"* || "$path" == *"02_cloud_k8s_container_escape"* || "$path" == *"06_aws_cloud_security"* || "$path" == *"08_gcp_cloud_security"* ]]; then
                    item_cat="06_cloud_k8s_ai"
                elif [[ "$path" == *"03_devsecops_ci_cd_poisoning"* ]]; then
                    item_cat="07_devsecops"
                elif [[ "$path" == *"05_api_gateway_oauth_oidc"* || "$path" == *"07_web3_smart_contracts"* || "$path" == *"10_iot_firmware_hardware_hacking"* ]]; then
                    item_cat="08_oauth_iot"
                else
                    item_cat="06_cloud_k8s_ai"
                fi
            elif [[ -z "$item_cat" ]]; then
                # Fallback path-based classification if section headers were absent
                if [[ "$path" == *"01_cyber_security_ethical_hacking"* ]]; then
                    item_cat="01_ethical_hacking"
                elif [[ "$path" == *"02_web_penetration_tester"* ]]; then
                    if [[ "$path" == *"vulhub"* || "$path" == *"skf"* ]]; then
                        item_cat="10_vulhub_skf"
                    else
                        item_cat="02_web_pentesting"
                    fi
                elif [[ "$path" == *"03_network_security"* ]]; then
                    item_cat="03_network_security"
                elif [[ "$path" == *"04_network_penetration_tester"* ]]; then
                    if [[ "$path" == *"vulhub"* || "$path" == *"skf"* ]]; then
                        item_cat="10_vulhub_skf"
                    else
                        item_cat="04_network_pentesting"
                    fi
                elif [[ "$path" == *"05_exploit_writing"* ]]; then
                    item_cat="05_exploit_writing"
                elif [[ "$path" == tools/* ]]; then
                    item_cat="09_tools"
                elif [[ "$path" == *"09_infrastructure_server_cves"* || "$path" == *"vulhub"* || "$path" == *"skf"* ]]; then
                    item_cat="10_vulhub_skf"
                elif [[ "$path" == *"01_llm_ai_security"* || "$path" == *"02_cloud_k8s_container_escape"* || "$path" == *"06_aws_cloud_security"* || "$path" == *"08_gcp_cloud_security"* ]]; then
                    item_cat="06_cloud_k8s_ai"
                elif [[ "$path" == *"03_devsecops_ci_cd_poisoning"* ]]; then
                    item_cat="07_devsecops"
                elif [[ "$path" == *"05_api_gateway_oauth_oidc"* || "$path" == *"07_web3_smart_contracts"* || "$path" == *"10_iot_firmware_hardware_hacking"* ]]; then
                    item_cat="08_oauth_iot"
                else
                    item_cat="10_vulhub_skf"
                fi
            fi

            LAB_CATEGORY["$key"]="$item_cat"

            if [[ -z "${CATEGORY_LABS[$item_cat]:-}" ]]; then
                CATEGORY_LABS["$item_cat"]="$key"
            else
                CATEGORY_LABS["$item_cat"]+=$'\n'"$key"
            fi

            abs_path="${CYBERLAB_ROOT}/${path}"
            PATH_TO_KEY["$abs_path"]="$key"
            PATH_TO_KEY["$path"]="$key"
        fi
    done <"$lab_file"

    # Write serialized cache with global (-g) scope so sourcing inside functions populates globals
    local tmp_cache="${cache_file}.tmp.$$"
    if declare -p LABS LAB_CATEGORY PATH_TO_KEY CATEGORY_LABS ALL_LAB_KEYS 2>/dev/null |
        sed -e 's/^declare -A/declare -gA/' -e 's/^declare -a/declare -ga/' >"$tmp_cache"; then
        mv -f "$tmp_cache" "$cache_file" 2>/dev/null || rm -f "$tmp_cache" 2>/dev/null
    else
        rm -f "$tmp_cache" 2>/dev/null
    fi

    return 0
}

# Auto-ensure catalog is loaded before accessing metadata
_core_ensure_loaded() {
    if [[ ${#LABS[@]} -eq 0 ]]; then
        core_load_labs
    fi
}

get_lab_path() {
    local target="$1"
    _core_ensure_loaded
    if [[ -n "${LABS[$target]:-}" ]]; then
        local path desc port
        IFS="|" read -r path desc port <<<"${LABS[$target]}"
        echo "${CYBERLAB_ROOT}/${path}"
    else
        echo ""
    fi
}

get_lab_desc() {
    local target="$1"
    _core_ensure_loaded
    if [[ -n "${LABS[$target]:-}" ]]; then
        local path desc port
        IFS="|" read -r path desc port <<<"${LABS[$target]}"
        echo "$desc"
    else
        echo ""
    fi
}

get_lab_port() {
    local target="$1"
    _core_ensure_loaded
    if [[ -n "${LABS[$target]:-}" ]]; then
        local path desc port
        IFS="|" read -r path desc port <<<"${LABS[$target]}"
        echo "$port"
    else
        echo ""
    fi
}

get_lab_category() {
    local target="$1"
    _core_ensure_loaded
    echo "${LAB_CATEGORY[$target]:-}"
}

core_get_categories() {
    printf "%s\n" "${CATEGORIES[@]}"
}

core_get_category_title() {
    local cat="$1"
    echo "${CATEGORY_TITLES[$cat]:-$cat}"
}

core_get_labs_by_category() {
    local cat="$1"
    _core_ensure_loaded
    if [[ -n "${CATEGORY_LABS[$cat]:-}" ]]; then
        printf "%s\n" "${CATEGORY_LABS[$cat]}"
    fi
}

core_get_all_labs() {
    _core_ensure_loaded
    printf "%s\n" "${ALL_LAB_KEYS[@]}"
}

# ------------------------------------------------------------------------------
# 2. Docker Operational Functions
# ------------------------------------------------------------------------------

# Check if lab containers are running
core_is_running() {
    local target="$1"
    local lab_path
    lab_path=$(get_lab_path "$target")
    if [[ -z "$lab_path" || ! -d "$lab_path" ]]; then
        return 1
    fi

    # Fast inspection via docker label
    local norm_path="${lab_path%/}"
    local is_up
    is_up=$(docker ps --filter "label=com.docker.compose.project.working_dir=${norm_path}" -q 2>/dev/null)
    if [[ -n "$is_up" ]]; then
        return 0
    fi

    # Fallback inspection inside lab directory
    local running_services
    running_services=$( (cd "$lab_path" && docker compose ps --services --filter "status=running" 2>/dev/null) || true )
    if [[ -n "$running_services" ]]; then
        return 0
    fi

    return 1
}

# Return newline-separated list of all currently running lab keys
core_get_running_labs() {
    _core_ensure_loaded

    local -A seen_keys=()
    local compose_dirs=()
    mapfile -t compose_dirs < <(docker ps --format '{{.Label "com.docker.compose.project.working_dir"}}' 2>/dev/null | sort -u)

    for dir in "${compose_dirs[@]}"; do
        [[ -z "$dir" ]] && continue
        local norm_dir="${dir%/}"
        if [[ -n "${PATH_TO_KEY[$norm_dir]:-}" ]]; then
            seen_keys["${PATH_TO_KEY[$norm_dir]}"]=1
        fi
    done

    # Output unique keys
    for k in "${!seen_keys[@]}"; do
        echo "$k"
    done | sort
}

# Start lab using docker compose up -d
core_start_lab() {
    local target="$1"
    local log_file="${2:-}"
    local lab_path
    lab_path=$(get_lab_path "$target")
    if [[ -z "$lab_path" || ! -d "$lab_path" ]]; then
        echo "Error: Unknown lab or directory not found for '$target'" >&2
        return 1
    fi

    if [[ -n "$log_file" ]]; then
        (cd "$lab_path" && docker compose up -d) >"$log_file" 2>&1
    else
        (cd "$lab_path" && docker compose up -d)
    fi
}

# Stop lab using docker compose down
core_stop_lab() {
    local target="$1"
    local log_file="${2:-}"
    local lab_path
    lab_path=$(get_lab_path "$target")
    if [[ -z "$lab_path" || ! -d "$lab_path" ]]; then
        echo "Error: Unknown lab or directory not found for '$target'" >&2
        return 1
    fi

    if [[ -n "$log_file" ]]; then
        (cd "$lab_path" && docker compose down) >"$log_file" 2>&1
    else
        (cd "$lab_path" && docker compose down)
    fi
}

# Restart lab using docker compose restart
core_restart_lab() {
    local target="$1"
    local log_file="${2:-}"
    local lab_path
    lab_path=$(get_lab_path "$target")
    if [[ -z "$lab_path" || ! -d "$lab_path" ]]; then
        echo "Error: Unknown lab or directory not found for '$target'" >&2
        return 1
    fi

    if [[ -n "$log_file" ]]; then
        (cd "$lab_path" && docker compose restart) >"$log_file" 2>&1
    else
        (cd "$lab_path" && docker compose restart)
    fi
}

# Pull container images for a lab
core_pull_lab() {
    local target="$1"
    local log_file="${2:-}"
    local lab_path
    lab_path=$(get_lab_path "$target")
    if [[ -z "$lab_path" || ! -d "$lab_path" ]]; then
        echo "Error: Unknown lab or directory not found for '$target'" >&2
        return 1
    fi

    if [[ -n "$log_file" ]]; then
        (cd "$lab_path" && docker compose pull) >"$log_file" 2>&1
    else
        (cd "$lab_path" && docker compose pull)
    fi
}

# Connect interactive shell to the primary service
core_shell_lab() {
    local target="$1"
    local lab_path
    lab_path=$(get_lab_path "$target")
    if [[ -z "$lab_path" || ! -d "$lab_path" ]]; then
        echo "Error: Unknown lab or directory not found for '$target'" >&2
        return 1
    fi

    local service_name
    service_name=$(cd "$lab_path" && docker compose ps --services --filter "status=running" 2>/dev/null | head -n 1)
    if [[ -z "$service_name" ]]; then
        service_name=$(cd "$lab_path" && docker compose ps --services 2>/dev/null | head -n 1)
    fi

    if [[ -z "$service_name" ]]; then
        echo "Error: Lab '$target' has no running services. Start it first: core_start_lab $target" >&2
        return 1
    fi

    # Save terminal mode and restore cursor / echo
    local term_saved=""
    if command -v stty >/dev/null 2>&1; then
        term_saved=$(stty -g 2>/dev/null || true)
        stty sane 2>/dev/null || true
        stty echo 2>/dev/null || true
    fi

    tput cnorm 2>/dev/null || printf "\033[?25h"

    echo "==> Attaching interactive shell to service: $service_name ($target)..."
    (
        cd "$lab_path" || exit 1
        docker compose exec -it "$service_name" /bin/bash 2>/dev/null ||
            docker compose exec -it "$service_name" /bin/sh 2>/dev/null ||
            echo "Error: Could not spawn /bin/bash or /bin/sh inside container." >&2
    )

    echo ""
    read -rp "[CyberLab] Session closed. Press [ENTER] to return..." _dummy || true

    # Restore saved terminal configuration
    if [[ -n "$term_saved" ]]; then
        stty "$term_saved" 2>/dev/null || true
    fi
}

# Stop all running CyberLab compose projects and cyberlab_ containers
core_stop_all() {
    echo "Stopping all running CyberLab containers..."
    local stopped_any=0

    # 1. Stop all Compose projects located under CYBERLAB_ROOT
    local compose_dirs=()
    mapfile -t compose_dirs < <(docker ps --format '{{.Label "com.docker.compose.project.working_dir"}}' 2>/dev/null | sort -u)
    for dir in "${compose_dirs[@]}"; do
        [[ -z "$dir" ]] && continue
        if [[ "$dir" == "${CYBERLAB_ROOT}"* && -d "$dir" ]]; then
            echo " -> Stopping compose project in: $dir"
            (cd "$dir" && docker compose down 2>/dev/null) || true
            stopped_any=1
        fi
    done

    # 2. Stop any remaining standalone containers with name cyberlab_
    local containers
    containers=$(docker ps -q --filter "name=cyberlab_" 2>/dev/null || true)
    if [[ -n "$containers" ]]; then
        echo " -> Stopping leftover cyberlab_ containers: $containers"
        # shellcheck disable=SC2086
        docker stop $containers 2>/dev/null || true
        stopped_any=1
    fi

    if [[ "$stopped_any" -eq 1 ]]; then
        echo "All CyberLab containers stopped."
    else
        echo "No CyberLab containers currently running."
    fi
}

# Return contents of docker-compose.yml
core_get_compose_content() {
    local target="$1"
    local lab_path
    lab_path=$(get_lab_path "$target")
    if [[ -z "$lab_path" || ! -d "$lab_path" ]]; then
        return 1
    fi

    for file in "docker-compose.yml" "docker-compose.yaml" "compose.yml" "compose.yaml"; do
        if [[ -f "$lab_path/$file" ]]; then
            cat "$lab_path/$file"
            return 0
        fi
    done
    return 1
}

# Return contents of README.md
core_get_readme_content() {
    local target="$1"
    local lab_path
    lab_path=$(get_lab_path "$target")
    if [[ -z "$lab_path" || ! -d "$lab_path" ]]; then
        return 1
    fi

    for file in "README.md" "readme.md" "README.MD" "README"; do
        if [[ -f "$lab_path/$file" ]]; then
            cat "$lab_path/$file"
            return 0
        fi
    done
    return 1
}

# Return recent logs for the lab
core_get_logs() {
    local target="$1"
    local tail="${2:-100}"
    local lab_path
    lab_path=$(get_lab_path "$target")
    if [[ -z "$lab_path" || ! -d "$lab_path" ]]; then
        echo "Error: Unknown lab or directory not found for '$target'" >&2
        return 1
    fi

    (cd "$lab_path" && docker compose logs --tail="$tail" --no-color 2>&1)
}
