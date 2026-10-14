#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$SCRIPT_DIR/workspace"

docker compose -f "$SCRIPT_DIR/docker-compose.yml" up -d
docker compose -f "$SCRIPT_DIR/docker-compose.yml" exec -it gcpgoat /bin/bash
