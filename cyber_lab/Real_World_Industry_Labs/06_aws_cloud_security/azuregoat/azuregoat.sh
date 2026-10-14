#!/usr/bin/env bash
# ==============================================================================
# CyberLab AzureGoat Workspace Shell Launcher
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [ -z "$(docker compose ps -q azuregoat 2>/dev/null)" ]; then
    echo "[*] AzureGoat workspace container is not running. Starting it now..."
    docker compose up -d
fi

echo "[+] Connecting to interactive shell in cyberlab_azuregoat..."
docker compose exec -it azuregoat /bin/bash
