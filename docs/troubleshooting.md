# Troubleshooting

## Nginx Shows 502 Bad Gateway

Check the backend:

```bash
sudo systemctl status demo-api
curl http://127.0.0.1:8080/actuator/health
```

Check that the Nginx upstream port matches `SERVER_PORT`.

## Static Site Refresh Returns 404

Use the SPA fallback:

```nginx
try_files $uri $uri/ /index.html;
```

## HTTPS Certificate Fails

Check:

- domain A record points to the server IP
- ports 80 and 443 are open
- Nginx config passes `sudo nginx -t`

## CORS Fails

Do not use `*` with credentials. Add your exact frontend origin in `nginx-configs/cors-api.conf`.
