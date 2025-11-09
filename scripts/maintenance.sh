#!/usr/bin/env bash
set -euo pipefail

# Very short maintenance wrapper
# Usage: maintenance.sh [--backup] [--update] [--monitor] [--all]
DIR="$(dirname "$0")"
if [[ ${1:-} == "--backup" ]]; then
  "$DIR/backup.sh" --dry-run
elif [[ ${1:-} == "--update" ]]; then
  "$DIR/update.sh" --simulate
elif [[ ${1:-} == "--monitor" ]]; then
  "$DIR/monitor_logs.sh"
elif [[ ${1:-} == "--all" ]]; then
  "$DIR/backup.sh" --dry-run
  "$DIR/update.sh" --simulate
  "$DIR/monitor_logs.sh"
else
  echo "Usage: $0 --backup|--update|--monitor|--all"
fi

exit 0
