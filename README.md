# Student Deploy Kit

Student Deploy Kit is a beginner-friendly deployment toolkit for students, indie developers, and personal website maintainers.

It collects copy-ready Nginx configs, Spring Boot deployment scripts, frontend deployment templates, Docker Compose examples, and server security checklists in one repository.

中文说明：[README.zh-CN.md](README.zh-CN.md)

## Who This Helps

- Graduation projects that need to go online quickly.
- Spring Boot + Vue/React personal projects.
- Static portfolios hosted on a small VPS.
- New developers who know how to code but get stuck on Nginx, HTTPS, systemd, firewalls, and logs.

## Quick Start

Pick the module you need:

```text
nginx-configs/        Nginx templates for static sites, reverse proxy, HTTPS, CORS, and security headers
springboot-deploy/    Spring Boot build, deploy, systemd, and logrotate templates
frontend-deploy/      Vue/React/static site deployment scripts and Nginx examples
server-security/      Ubuntu firewall, SSH, swap, and baseline hardening helpers
docker/               Dockerfile and Docker Compose examples for full-stack projects
docs/                 Step-by-step guides and troubleshooting
examples/             Tiny example site for smoke testing
```

For a typical Spring Boot + frontend project:

```bash
# 1. Build and upload your backend jar.
bash springboot-deploy/deploy-springboot.sh \
  --app-name demo-api \
  --jar target/demo-api.jar \
  --deploy-dir /opt/demo-api \
  --port 8080

# 2. Build and deploy your frontend.
bash frontend-deploy/deploy-static.sh \
  --source dist \
  --target /var/www/demo-web

# 3. Copy an Nginx template.
sudo cp nginx-configs/fullstack-springboot.conf /etc/nginx/sites-available/demo.conf
sudo ln -s /etc/nginx/sites-available/demo.conf /etc/nginx/sites-enabled/demo.conf
sudo nginx -t && sudo systemctl reload nginx
```

## What Is Included

- Static website Nginx config.
- Spring Boot reverse proxy Nginx config.
- HTTPS-ready Nginx config with safe defaults.
- CORS template for API projects.
- Spring Boot deployment script.
- systemd service template.
- logrotate template.
- Frontend static deployment script.
- Docker Compose example for frontend + Spring Boot + Nginx.
- Ubuntu server baseline checklist and helper script.
- GitHub Actions deployment example.

## Safety Notes

Read every script before running it on a real server. The templates are intentionally explicit and commented so you can change ports, domains, users, and paths.

Do not commit `.env`, private keys, SSH keys, database passwords, or server tokens.

## Good First Issues

- Add a Node.js deployment template.
- Add a Python FastAPI deployment template.
- Add a Tencent Cloud / Alibaba Cloud guide.
- Add a Chinese video-style quickstart script.
- Add Caddy templates.
- Add Windows Server notes.
- Add more troubleshooting cases.

## License

MIT
