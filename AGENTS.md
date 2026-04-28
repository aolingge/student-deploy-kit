# Repository Agent Instructions

## Scope

- Follow `README.md`, `README.zh-CN.md`, and the template directories before adding new tooling.
- Keep deployment examples copy-ready, minimal, and safe for student projects.
- Do not commit secrets, tokens, cookies, generated credentials, browser profiles, private logs, or local machine paths.
- Do not run `sudo` deployment commands or change a real server unless explicitly requested.

## Commands

- Validate templates: `bash scripts/validate.sh`.
- Docker template check: `docker compose -f docker/docker-compose.fullstack.yml config` when Docker is available and Docker templates changed.

## Verification

Run the narrowest relevant validation after edits. For docs-only changes, inspect the touched Markdown and linked template paths. Avoid destructive deployment commands during local verification.

## Git

- Preserve unrelated dirty changes.
- Do not rewrite history, delete branches, push, publish, or open PRs without explicit confirmation.
