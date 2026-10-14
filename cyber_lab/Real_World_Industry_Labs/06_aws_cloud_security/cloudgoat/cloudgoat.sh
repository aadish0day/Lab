#!/usr/bin/env bash
# ==============================================================================
# CloudGoat CLI Interactive Workspace Launcher
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

mkdir -p workspace

echo "[*] Launching CloudGoat container workspace..."
docker compose up -d

echo "[+] Connecting to interactive CloudGoat shell..."
docker compose exec -it cloudgoat /bin/bash
