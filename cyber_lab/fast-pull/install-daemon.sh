#!/usr/bin/env bash
#
# Install daemon.json for faster image pulls and restart Docker.
#
#   * registry-mirrors        -> mirror.gcr.io (Docker Hub pull-through cache)
#   * max-concurrent-downloads-> 16 parallel layer downloads (default 3)
#   * max-concurrent-uploads  -> 8
#   * max-download-attempts   -> 10 retries on flaky layer fetches
#
# NOTE: restarting Docker stops every running container. Run this when the
# host is idle, or accept that running labs will be restarted.
#
# Usage:  ./install-daemon.sh
#
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HERE/daemon.json"
DEST="/etc/docker/daemon.json"

if [[ ! -f "$SRC" ]]; then
	echo "daemon.json not found next to this script: $SRC" >&2
	exit 1
fi

sudo mkdir -p /etc/docker

if [[ -f "$DEST" ]]; then
	backup="${DEST}.bak.$(date +%Y%m%d%H%M%S)"
	echo "Backing up existing config -> $backup"
	sudo cp "$DEST" "$backup"
fi

sudo cp "$SRC" "$DEST"
echo "Wrote $DEST:"
sudo cat "$DEST"

echo
echo "Restarting Docker..."
if command -v systemctl >/dev/null 2>&1; then
	sudo systemctl restart docker
else
	sudo service docker restart
fi

echo
echo "Done. Verify with:  docker info | grep -A2 'Registry Mirrors'"
