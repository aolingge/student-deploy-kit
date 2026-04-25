#!/usr/bin/env bash
set -euo pipefail

APP_NAME="demo-api"
JAR_PATH=""
DEPLOY_DIR="/opt/demo-api"
PORT="8080"
RUN_USER="www-data"

usage() {
  cat <<'USAGE'
Usage:
  bash springboot-deploy/deploy-springboot.sh --jar target/app.jar [options]

Options:
  --app-name NAME       systemd service name, default: demo-api
  --jar PATH           local jar path to deploy
  --deploy-dir PATH    target directory, default: /opt/demo-api
  --port PORT          app port written to .env, default: 8080
  --user USER          system user, default: www-data
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --app-name) APP_NAME="$2"; shift 2 ;;
    --jar) JAR_PATH="$2"; shift 2 ;;
    --deploy-dir) DEPLOY_DIR="$2"; shift 2 ;;
    --port) PORT="$2"; shift 2 ;;
    --user) RUN_USER="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$JAR_PATH" || ! -f "$JAR_PATH" ]]; then
  echo "Jar not found. Pass --jar target/your-app.jar" >&2
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo because this writes to $DEPLOY_DIR and /etc/systemd/system." >&2
  exit 1
fi

install -d -o "$RUN_USER" -g "$RUN_USER" "$DEPLOY_DIR"
install -d -o "$RUN_USER" -g "$RUN_USER" "$DEPLOY_DIR/releases"
install -d -o "$RUN_USER" -g "$RUN_USER" "$DEPLOY_DIR/logs"

STAMP="$(date +%Y%m%d%H%M%S)"
TARGET_JAR="$DEPLOY_DIR/releases/$APP_NAME-$STAMP.jar"
install -o "$RUN_USER" -g "$RUN_USER" -m 0644 "$JAR_PATH" "$TARGET_JAR"
ln -sfn "$TARGET_JAR" "$DEPLOY_DIR/app.jar"

cat > "$DEPLOY_DIR/.env" <<EOF
SERVER_PORT=$PORT
JAVA_OPTS=-Xms256m -Xmx512m
SPRING_PROFILES_ACTIVE=prod
EOF
chown "$RUN_USER:$RUN_USER" "$DEPLOY_DIR/.env"
chmod 0640 "$DEPLOY_DIR/.env"

sed \
  -e "s|{{APP_NAME}}|$APP_NAME|g" \
  -e "s|{{DEPLOY_DIR}}|$DEPLOY_DIR|g" \
  -e "s|{{RUN_USER}}|$RUN_USER|g" \
  "$(dirname "$0")/systemd.service.template" \
  > "/etc/systemd/system/$APP_NAME.service"

systemctl daemon-reload
systemctl enable "$APP_NAME"
systemctl restart "$APP_NAME"
systemctl --no-pager --full status "$APP_NAME"
