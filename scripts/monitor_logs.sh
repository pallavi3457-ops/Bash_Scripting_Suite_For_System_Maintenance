#!/usr/bin/env bash
set -euo pipefail

# monitor_logs.sh - scan log files for patterns and write alerts
# Usage: monitor_logs.sh [--follow] [--pattern PATTERN] [logfile...]

FOLLOW=0
PATTERN='ERROR|WARN|CRITICAL'
if [[ ${1:-} == "--help" ]]; then
  echo "Usage: $0 [--follow] [--pattern PATTERN] [logfile...]"
  exit 0
fi
if [[ ${1:-} == "--follow" ]]; then
  FOLLOW=1
  shift
fi
if [[ ${1:-} == "--pattern" ]]; then
  shift
  PATTERN=${1:-$PATTERN}
  shift
fi

LOG_DIR="$(dirname "$(dirname "$0")")/logs"
ALERTS="$LOG_DIR/alerts.log"
#!/usr/bin/env bash
set -euo pipefail

# Short monitor script — easy to explain
# Usage: monitor_logs.sh [--follow] [pattern] [files...]
FOLLOW=0
if [[ ${1:-} == "--follow" ]]; then FOLLOW=1; shift; fi
PATTERN=${1:-'ERROR|WARN|CRITICAL'}
shift || true
FILES=("${@:-/var/log/syslog /var/log/messages /var/log/*log}")
ROOT="$(dirname "$(dirname "$0")")"
ALERTS="$ROOT/logs/alerts.log"
mkdir -p "$(dirname "$ALERTS")"

if [[ $FOLLOW -eq 1 ]]; then
  # follow mode (stream matches into alerts log)
  tail -F "${FILES[@]}" 2>/dev/null | grep -E --line-buffered "$PATTERN" >>"$ALERTS"
else
  # one-shot: append matches
  grep -E -H "$PATTERN" "${FILES[@]}" 2>/dev/null >>"$ALERTS" || true
fi

exit 0
