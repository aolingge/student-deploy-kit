# Deploy Vue, React, Or Static HTML

## 1. Build

React / Vite:

```bash
npm ci
npm run build
```

Vue / Vite:

```bash
npm ci
npm run build
```

Plain HTML:

Use your project folder as the source.

## 2. Upload To Nginx Web Root

```bash
sudo bash frontend-deploy/deploy-static.sh \
  --source dist \
  --target /var/www/demo-web
```

## 3. Enable Nginx Config

```bash
sudo cp nginx-configs/static-site.conf /etc/nginx/sites-available/demo-web.conf
sudo ln -s /etc/nginx/sites-available/demo-web.conf /etc/nginx/sites-enabled/demo-web.conf
sudo nginx -t
sudo systemctl reload nginx
```

## SPA Routing

The default config uses:

```nginx
try_files $uri $uri/ /index.html;
```

This keeps Vue Router and React Router routes working after refresh.
