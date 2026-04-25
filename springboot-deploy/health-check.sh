#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://127.0.0.1:8080/actuator/health}"

echo "Checking $URL"
code="$(curl -sS -o /tmp/student-deploy-health.txt -w '%{http_code}' "$URL" || true)"

if [[ "$code" != "200" ]]; then
  echo "Health check failed with HTTP $code"
  cat /tmp/student-deploy-health.txt || true
  exit 1
fi

echo "Health check passed"
