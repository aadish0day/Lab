#!/usr/bin/env bash
#
# docker-reset.sh — Wipe Docker back to a clean state.
#
# Removes ALL containers, images, volumes, custom networks and build cache,
# and tears down any Docker Compose project in the current directory.
#
# Usage:
#   ./docker-reset.sh            Interactive: asks for confirmation first.
#   ./docker-reset.sh --force    Unattended / CI: no prompt (alias: -y)
#
# Nothing is preserved. This cannot be undone.

set -uo pipefail

FORCE=0
case "${1:-}" in
  --force|-y) FORCE=1 ;;
  -h|--help)
    sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
    exit 0
    ;;
  "") ;;
  *) printf 'Unknown argument: %s\n' "$1" >&2; exit 2 ;;
esac

# --- helpers -----------------------------------------------------------------
log()  { printf '[docker-reset] %s\n' "$*"; }
warn() { printf '[docker-reset] ! %s\n' "$*" >&2; }
die()  { printf '[docker-reset] ERROR: %s\n' "$*" >&2; exit 1; }

# --- preflight ---------------------------------------------------------------
command -v docker >/dev/null 2>&1 || die "Docker CLI not found. Install Docker first."
docker info >/dev/null 2>&1 || die "Docker daemon is not running. Start it and try again."

# --- confirmation ------------------------------------------------------------
if [[ $FORCE -eq 0 ]]; then
  printf '\nWARNING: This will DELETE EVERYTHING in Docker:\n'
  printf '  - All containers (running and stopped)\n'
  printf '  - All images\n'
  printf '  - All volumes\n'
  printf '  - All custom networks\n'
  printf '  - Build cache\n'
  printf '\nThis cannot be undone.\n\n'
  read -r -p "Type YES to continue: " confirm
  [[ "$confirm" == "YES" ]] || die "Aborted."
fi

removed_containers=0
removed_images=0
removed_volumes=0
removed_networks=0

# 1. Docker Compose teardown ------------------------------------------------
if [[ -f docker-compose.yml || -f docker-compose.yaml || -f compose.yml || -f compose.yaml ]]; then
  log "Compose file found — tearing down the project"
  if docker compose version >/dev/null 2>&1; then
    docker compose down -v --remove-orphans >/dev/null 2>&1 || warn "Compose down reported issues (continuing)"
  elif command -v docker-compose >/dev/null 2>&1; then
    docker-compose down -v --remove-orphans >/dev/null 2>&1 || warn "Compose down reported issues (continuing)"
  else
    warn "Compose file present but neither 'docker compose' nor 'docker-compose' is available (skipping)"
  fi
fi

# 2. Containers ---------------------------------------------------------------
container_ids=$(docker ps -aq 2>/dev/null || true)
if [[ -n "$container_ids" ]]; then
  removed_containers=$(printf '%s\n' "$container_ids" | wc -l)
  log "Removing $removed_containers container(s)"
  # shellcheck disable=SC2086
  docker rm -f $container_ids >/dev/null 2>&1 || warn "Some containers could not be removed"
else
  log "No containers to remove"
fi

# 3. Images -------------------------------------------------------------------
image_ids=$(docker images -q 2>/dev/null || true)
if [[ -n "$image_ids" ]]; then
  removed_images=$(printf '%s\n' "$image_ids" | wc -l)
  log "Removing $removed_images image(s)"
  # shellcheck disable=SC2086
  docker rmi -f $image_ids >/dev/null 2>&1 || warn "Some images could not be removed directly"
fi
# Catch any images left behind by parent/child references.
docker image prune -af >/dev/null 2>&1 || true

# 4. Volumes ------------------------------------------------------------------
volume_ids=$(docker volume ls -q 2>/dev/null || true)
if [[ -n "$volume_ids" ]]; then
  removed_volumes=$(printf '%s\n' "$volume_ids" | wc -l)
  log "Removing $removed_volumes volume(s)"
  # shellcheck disable=SC2086
  docker volume rm $volume_ids >/dev/null 2>&1 || warn "Some volumes could not be removed"
else
  log "No volumes to remove"
fi

# 5. Custom networks ----------------------------------------------------------
network_ids=$(docker network ls --filter type=custom -q 2>/dev/null || true)
if [[ -n "$network_ids" ]]; then
  removed_networks=$(printf '%s\n' "$network_ids" | wc -l)
  log "Removing $removed_networks custom network(s)"
  # shellcheck disable=SC2086
  docker network rm $network_ids >/dev/null 2>&1 || warn "Some networks could not be removed"
else
  log "No custom networks to remove"
fi

# 6. Build cache --------------------------------------------------------------
log "Pruning build cache"
docker builder prune -af >/dev/null 2>&1 || warn "Build cache prune reported issues"

# --- summary -----------------------------------------------------------------
printf '\n=== Docker reset complete ===\n'
printf '  Containers removed : %d\n' "$removed_containers"
printf '  Images removed     : %d\n' "$removed_images"
printf '  Volumes removed    : %d\n' "$removed_volumes"
printf '  Networks removed   : %d\n' "$removed_networks"
printf '  Build cache        : pruned\n'
printf '\nDocker is now reset to a clean state.\n'
