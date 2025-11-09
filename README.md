# 🧰 Bash Script Suite — Quick Manual Run Guide

A collection of **simple Bash scripts** for basic system maintenance.  
Designed to be **minimal, safe, and easy to explain** — ideal for demonstrations or interviews.

---

## 📜 Scripts Overview

| Script | Purpose | Key Options |
|--------|----------|-------------|
| `scripts/backup.sh` | Create a timestamped `.tar.gz` archive of specified paths (default: `/etc`, `/var/log`). | `--dry-run` → preview without writing files |
| `scripts/update.sh` | Auto-detects package manager (`apt`, `yum`, `dnf`, `pacman`) and runs system updates. | `--simulate` → preview without real updates |
| `scripts/monitor_logs.sh` | Searches logs for `ERROR`, `WARN`, or `CRITICAL` messages and appends matches to `logs/alerts.log`. | `--follow` → live streaming mode |
| `scripts/maintenance.sh` | Wrapper script to safely run the above scripts with non-destructive flags. | `--all` → execute all safe tasks |

---

## ⚙️ Setup

Make all scripts executable:

```bash
chmod +x scripts/*.sh
chmod +x tests/run_smoke.sh
