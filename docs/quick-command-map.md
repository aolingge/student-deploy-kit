# Quick Command Map

## Nginx

```bash
sudo nginx -t
sudo systemctl reload nginx
sudo tail -f /var/log/nginx/error.log
```

## Spring Boot

```bash
sudo systemctl status demo-api
sudo journalctl -u demo-api -n 100 --no-pager
bash springboot-deploy/health-check.sh http://127.0.0.1:8080/actuator/health
```

## Frontend

```bash
npm ci
npm run build
sudo bash frontend-deploy/deploy-static.sh --source dist --target /var/www/demo-web
```

## Docker

```bash
docker compose -f docker/docker-compose.fullstack.yml config
docker compose -f docker/docker-compose.fullstack.yml up -d
docker compose -f docker/docker-compose.fullstack.yml logs -f
```
