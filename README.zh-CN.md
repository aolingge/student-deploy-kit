# Student Deploy Kit

专为学生、独立开发者、毕设项目和个人网站准备的部署工具包。

这个仓库把常见部署坑整理成可复制使用的模板：Nginx 配置、Spring Boot 部署脚本、Vue/React 静态站点部署、Docker Compose、服务器安全基线、常见问题排查。

## 适合谁

- 毕设项目写完了，但不知道怎么部署到云服务器。
- Spring Boot + Vue/React 项目需要上线演示。
- 个人网站、作品集、博客想放到 VPS。
- 会写代码，但被 Nginx、HTTPS、跨域、systemd、日志卡住的新手。

## 快速开始

常见 Spring Boot + 前端项目：

```bash
# 部署后端 jar
sudo bash springboot-deploy/deploy-springboot.sh \
  --app-name demo-api \
  --jar target/demo-api.jar \
  --deploy-dir /opt/demo-api \
  --port 8080

# 部署前端 dist
sudo bash frontend-deploy/deploy-static.sh \
  --source dist \
  --target /var/www/demo-web

# 配 Nginx
sudo cp nginx-configs/fullstack-springboot.conf /etc/nginx/sites-available/demo.conf
sudo ln -s /etc/nginx/sites-available/demo.conf /etc/nginx/sites-enabled/demo.conf
sudo nginx -t && sudo systemctl reload nginx
```

## 目录说明

```text
nginx-configs/        Nginx 配置：静态站点、反向代理、HTTPS、跨域、安全头
springboot-deploy/    Spring Boot 部署、systemd、日志切割、健康检查
frontend-deploy/      Vue/React/静态网页部署脚本
server-security/      Ubuntu 防火墙、fail2ban、安全检查清单
docker/               Dockerfile 和 Docker Compose 示例
docs/                 教程、FAQ、故障排查、命令速查
examples/             可直接部署测试的静态页面
```

## 你可以贡献什么

- Node.js / Python / PHP 部署模板。
- 阿里云、腾讯云、华为云部署教程。
- 宝塔面板迁移到 Nginx/systemd 的教程。
- Caddy 配置。
- 更多真实报错和解决方案。

## 安全提醒

运行任何 `sudo` 脚本前都要先读一遍脚本内容。不要把 `.env`、数据库密码、SSH 私钥、Token 提交到 GitHub。

## License

MIT
