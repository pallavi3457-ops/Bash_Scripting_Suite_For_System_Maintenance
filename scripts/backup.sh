#!/usr/bin/env bash
set -euo pipefail

# Minimal backup script — easy to explain in an interview
# Usage: backup.sh [--dry-run] [path...]

ROOT="$(dirname "$(dirname "$0")")"
BACKDIR="$ROOT/logs/backups"
LOG="$ROOT/logs/backup.log"
DRY=0
if [[ ${1:-} == "--dry-run" ]]; then DRY=1; shift; fi
TARGETS=("${@:-/etc /var/log}")
mkdir -p "$BACKDIR"
mkdir -p "$(dirname "$LOG")"
ts=$(date -u +%Y%m%dT%H%M%SZ)
archive="$BACKDIR/backup-$ts.tar.gz"
echo "[$ts] backup dry=$DRY targets=${TARGETS[*]}" >>"$LOG"
if [[ $DRY -eq 1 ]]; then
	echo "dry run: would create $archive" >>"$LOG"
else
	tar -czf "$archive" "${TARGETS[@]}" >>"$LOG" 2>&1 || exit 1
	echo "[$ts] created $archive" >>"$LOG"
fi

# keep last 7 backups (simple, portable)
mapfile -t files < <(printf '%s
' "$BACKDIR"/backup-*.tar.gz 2>/dev/null | sort -r)
if [[ ${#files[@]} -gt 7 && -f "${files[0]}" ]]; then
	for f in "${files[@]:7}"; do
		rm -f -- "$f"
	done
fi
exit 0

