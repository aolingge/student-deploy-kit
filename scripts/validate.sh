#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "ERROR: $1" >&2
  exit 1
}

required_files=(
  README.md
  LICENSE
  CONTRIBUTING.md
  nginx-configs/static-site.conf
  nginx-configs/springboot-reverse-proxy.conf
  springboot-deploy/deploy-springboot.sh
  frontend-deploy/deploy-static.sh
  server-security/ubuntu-baseline.sh
  docker/docker-compose.fullstack.yml
)

for file in "${required_files[@]}"; do
  [[ -f "$file" ]] || fail "Missing $file"
done

for script in springboot-deploy/*.sh frontend-deploy/*.sh server-security/*.sh scripts/*.sh; do
  bash -n "$script"
done

if grep -RInE "(github_pat_|ghp_|AKIA[0-9A-Z]{16}|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY)" . \
  --exclude-dir=.git \
  --exclude=validate.sh \
  --exclude=package-lock.json; then
  fail "Potential secret pattern found"
fi

echo "Validation passed"
