#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(dirname "$(dirname "$0")")"
SCRIPTS="$ROOT_DIR/scripts"
LOGS="$ROOT_DIR/logs"

echo "Running smoke tests..."

mkdir -p "$LOGS"

echo "1) Test backup (dry-run)"
bash "$SCRIPTS/backup.sh" --dry-run

echo "2) Test update (help only)"
bash "$SCRIPTS/update.sh" --help

echo "3) Test monitor (one-shot)"
bash "$SCRIPTS/monitor_logs.sh"

echo "4) Test maintenance wrapper (backup+monitor only)"
bash "$SCRIPTS/maintenance.sh" --backup
bash "$SCRIPTS/maintenance.sh" --monitor

echo "Smoke test completed. Check logs in $LOGS"

exit 0
