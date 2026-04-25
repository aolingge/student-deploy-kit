# Deploy Spring Boot On A VPS

This guide assumes Ubuntu 22.04 or 24.04, Java 17, Nginx, and a Spring Boot jar.

## 1. Install Java And Nginx

```bash
sudo apt-get update
sudo apt-get install -y openjdk-17-jre nginx curl rsync
```

## 2. Build Your Jar

```bash
./mvnw clean package -DskipTests
```

or:

```bash
./gradlew bootJar
```

## 3. Deploy

```bash
sudo bash springboot-deploy/deploy-springboot.sh \
  --app-name demo-api \
  --jar target/demo-api.jar \
  --deploy-dir /opt/demo-api \
  --port 8080
```

## 4. Configure Nginx

```bash
sudo cp nginx-configs/springboot-reverse-proxy.conf /etc/nginx/sites-available/demo-api.conf
sudo ln -s /etc/nginx/sites-available/demo-api.conf /etc/nginx/sites-enabled/demo-api.conf
sudo nginx -t
sudo systemctl reload nginx
```

## Troubleshooting

- `502 Bad Gateway`: Spring Boot is not running or the Nginx upstream port is wrong.
- `Permission denied`: do not run the app from a private user directory like `/root`.
- `Address already in use`: another app is using the port.
