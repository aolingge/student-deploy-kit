#!/usr/bin/env bash
set -euo pipefail

SOURCE="dist"
TARGET="/var/www/demo-web"
OWNER="www-data"

usage() {
  cat <<'USAGE'
Usage:
  bash frontend-deploy/deploy-static.sh --source dist --target /var/www/demo-web

Options:
  --source PATH    built frontend directory, default: dist
  --target PATH    target web root, default: /var/www/demo-web
  --owner USER     file owner, default: www-data
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source) SOURCE="$2"; shift 2 ;;
    --target) TARGET="$2"; shift 2 ;;
    --owner) OWNER="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ ! -d "$SOURCE" ]]; then
  echo "Source directory not found: $SOURCE" >&2
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo because this writes to $TARGET." >&2
  exit 1
fi

install -d -o "$OWNER" -g "$OWNER" "$TARGET"
rsync -a --delete "$SOURCE"/ "$TARGET"/
chown -R "$OWNER:$OWNER" "$TARGET"

echo "Deployed $SOURCE to $TARGET"
