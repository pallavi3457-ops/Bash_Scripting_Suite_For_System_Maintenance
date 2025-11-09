#!/usr/bin/env bash
set -euo pipefail

#!/usr/bin/env bash
set -euo pipefail

# Real, minimal updater — easy to explain
# Usage: update.sh [--help]
if [[ ${1:-} == "--help" ]]; then
  echo "Usage: $0"; exit 0
fi

ROOT="$(dirname "$(dirname "$0")")"
LOG="$ROOT/logs/update.log"
mkdir -p "$(dirname "$LOG")"
echo "[ $(date -u +%Y%m%dT%H%M%SZ) ] starting update" >>"$LOG"

if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update >>"$LOG" 2>&1
  sudo apt-get -y upgrade >>"$LOG" 2>&1
elif command -v yum >/dev/null 2>&1; then
  sudo yum -y update >>"$LOG" 2>&1
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf -y upgrade >>"$LOG" 2>&1
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu --noconfirm >>"$LOG" 2>&1
else
  echo "no supported package manager" >>"$LOG"
  exit 2
fi

echo "[ $(date -u +%Y%m%dT%H%M%SZ) ] update finished" >>"$LOG"
exit 0
