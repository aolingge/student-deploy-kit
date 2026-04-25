#!/usr/bin/env bash
set -euo pipefail

APPLY="false"
SSH_PORT="22"

usage() {
  cat <<'USAGE'
Usage:
  bash server-security/ubuntu-baseline.sh --apply [--ssh-port 22]

What it does:
  - updates apt package index
  - installs ufw, fail2ban, curl, rsync
  - allows OpenSSH, HTTP, and HTTPS through ufw
  - enables ufw

Read the script before running it on a real server.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --apply) APPLY="true"; shift ;;
    --ssh-port) SSH_PORT="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ "$APPLY" != "true" ]]; then
  usage
  echo
  echo "Dry run only. Add --apply to change the server."
  exit 0
fi

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo." >&2
  exit 1
fi

apt-get update
apt-get install -y ufw fail2ban curl rsync ca-certificates

ufw allow "$SSH_PORT/tcp"
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

systemctl enable fail2ban
systemctl restart fail2ban

ufw status verbose
systemctl --no-pager status fail2ban
