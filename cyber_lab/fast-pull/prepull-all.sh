#!/usr/bin/env bash
#
# Pre-pull images for every docker-compose file in cyber_lab/ in parallel.
#
# Compose already pulls a handful of services concurrently; COMPOSE_PARALLEL_LIMIT
# raises that ceiling, and JOBS controls how many lab directories run at once.
#
# WARNING: this downloads images for ALL ~1800 labs. That is tens of GB of disk.
# Prefer `docker compose -f <file> pull` for just the labs you need. Use this
# only to warm the whole collection (e.g. overnight) or a filtered subset.
#
# Usage:
#   ./prepull-all.sh                 # all labs
#   JOBS=8 ./prepull-all.sh          # 8 labs at a time
#   ./prepull-all.sh Classes/02_web_penetration_tester/16_advanced_sql_injection
#
set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"

export COMPOSE_PARALLEL_LIMIT="${COMPOSE_PARALLEL_LIMIT:-16}"
JOBS="${JOBS:-4}"
FILTER="${1:-}"

if [[ -n "$FILTER" && "$FILTER" != *"*"* ]]; then
  FILTER="$FILTER*"
fi

list_labs() {
  if [[ -n "$FILTER" ]]; then
    # Let the shell expand globs in FILTER, then hand the paths to find.
    # shellcheck disable=SC2086
    set -- $ROOT/$FILTER
    find "$@" -name 'docker-compose*.y*ml' -print0 2>/dev/null
  else
    find "$ROOT" -name 'docker-compose*.y*ml' -print0
  fi
}

count="$(list_labs | tr -cd '\0' | wc -c)"
echo "Pre-pulling $count compose file(s), $JOBS at a time, COMPOSE_PARALLEL_LIMIT=$COMPOSE_PARALLEL_LIMIT"
echo "The registry mirror is only used if configured in /etc/docker/daemon.json (see install-daemon.sh)."
echo

list_labs | xargs -0 -P "$JOBS" -I{} sh -c '
  f="$1"
  if docker compose -f "$f" pull --quiet >/dev/null 2>&1; then
    echo "ok   $f"
  else
    echo "FAIL $f"
  fi
' _ {}

echo
echo "Finished. Failures above (if any) usually mean a rate-limit or a gone/broken tag."
