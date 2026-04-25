# Contributing

Thanks for improving Student Deploy Kit.

## Before You Open A Pull Request

Run the repository checks:

```bash
bash scripts/validate.sh
```

For config or script changes, include:

- the operating system you tested on
- the command you ran
- expected result
- actual result

## Contribution Rules

- Keep templates beginner-friendly.
- Add comments where a student would likely get stuck.
- Never include real domains, private IPs, passwords, tokens, cookies, or SSH keys.
- Prefer placeholders like `example.com`, `demo-api`, and `/opt/demo-api`.
- Keep dangerous commands visible and explained.

## Good Pull Requests

- Add one new deployment template.
- Improve one troubleshooting answer.
- Add comments to an existing config.
- Add a tested cloud provider note.

## Style

- Shell scripts should use `set -euo pipefail`.
- Nginx configs should include comments for placeholders.
- Docs should start with the shortest working path.
