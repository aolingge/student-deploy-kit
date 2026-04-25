<p align="center">
  <img src="assets/readme-banner.svg" alt="Student Deploy Kit banner" width="100%" />
</p>

<h1 align="center">Student Deploy Kit</h1>

<p align="center">
  <b>给学生项目、毕设演示、个人网站准备的可复制部署模板。</b>
</p>

<p align="center">
  <a href="README.md">English</a>
  ·
  <a href="#快速开始">快速开始</a>
  ·
  <a href="#按场景选择">按场景选择</a>
  ·
  <a href="#适合贡献的方向">参与贡献</a>
</p>

<p align="center">
  <a href="https://github.com/aolingge/student-deploy-kit/actions/workflows/validate.yml"><img src="https://img.shields.io/github/actions/workflow/status/aolingge/student-deploy-kit/validate.yml?branch=main&style=flat-square&label=templates" alt="Validation status" /></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/aolingge/student-deploy-kit?style=flat-square" alt="MIT license" /></a>
  <a href="https://github.com/aolingge/student-deploy-kit/releases"><img src="https://img.shields.io/github/v/release/aolingge/student-deploy-kit?style=flat-square" alt="Latest release" /></a>
  <img src="https://img.shields.io/badge/Docker-compose-2496ED?style=flat-square&logo=docker&logoColor=white" alt="Docker Compose" />
</p>

---

<table>
  <tr>
    <td width="25%" valign="top">
      <b><a href="nginx-configs/">Nginx & HTTPS</a></b><br />
      反向代理、TLS、CORS、安全头。
    </td>
    <td width="25%" valign="top">
      <b><a href="springboot-deploy/">Spring Boot Deploy</a></b><br />
      systemd、jar 发布、日志、健康检查。
    </td>
    <td width="25%" valign="top">
      <b><a href="frontend-deploy/">Frontend Deploy</a></b><br />
      dist 上传、静态站点、SPA fallback。
    </td>
    <td width="25%" valign="top">
      <b><a href="server-security/">Server Security</a></b><br />
      SSH、防火墙、fail2ban、基线加固。
    </td>
  </tr>
</table>

## 为什么做这个项目

很多学生项目不是卡在代码，而是卡在最后一步部署：

- Spring Boot jar 本地能跑，放到服务器就不知道怎么常驻运行。
- Nginx 反向代理、跨域、HTTPS、前端刷新 404 总是配不对。
- Vue / React 的 `dist/` 打好了，但不知道应该放到哪里。
- 防火墙、systemd、日志、Docker 示例散落在各种文章里。

**Student Deploy Kit 把这些重复踩坑的问题整理成可以复制修改的模板。**

## 30 秒看懂结构

```text
浏览器
  |
  v
Nginx :80/:443
  |-- /        -> 前端 dist/ 或静态 HTML
  |-- /api/    -> Spring Boot 127.0.0.1:8080
  |-- HTTPS    -> Certbot 证书
  |-- logs     -> /var/log/nginx/*.log

systemd
  |-- 让 app.jar 常驻运行
  |-- 服务器重启后自动拉起
  |-- 写入日志方便排查
```

## 快速开始

部署常见 Spring Boot + Vue/React 项目：

```bash
# 1. 部署后端 jar
sudo bash springboot-deploy/deploy-springboot.sh \
  --app-name demo-api \
  --jar target/demo-api.jar \
  --deploy-dir /opt/demo-api \
  --port 8080

# 2. 部署前端 dist
sudo bash frontend-deploy/deploy-static.sh \
  --source dist \
  --target /var/www/demo-web

# 3. 启用 Nginx 全栈模板
sudo cp nginx-configs/fullstack-springboot.conf /etc/nginx/sites-available/demo.conf
sudo ln -s /etc/nginx/sites-available/demo.conf /etc/nginx/sites-enabled/demo.conf
sudo nginx -t && sudo systemctl reload nginx
```

看到下面结果就说明基本部署成功：

```bash
curl -I http://example.com
sudo systemctl status demo-api --no-pager
```

Nginx 应返回 `200` 或 `301`，`demo-api` 应显示 `active (running)`。

## 按场景选择

| 我想做什么 | 从这里开始 |
| --- | --- |
| 部署静态作品集或 Vue/React 网站 | [`nginx-configs/static-site.conf`](nginx-configs/static-site.conf), [`docs/frontend-vps.md`](docs/frontend-vps.md) |
| 把 Spring Boot 放到 Nginx 后面 | [`nginx-configs/springboot-reverse-proxy.conf`](nginx-configs/springboot-reverse-proxy.conf), [`docs/springboot-vps.md`](docs/springboot-vps.md) |
| 前后端用同一个域名 | [`nginx-configs/fullstack-springboot.conf`](nginx-configs/fullstack-springboot.conf) |
| 配 HTTPS | [`nginx-configs/https-certbot.conf`](nginx-configs/https-certbot.conf) |
| 解决 API 跨域 | [`nginx-configs/cors-api.conf`](nginx-configs/cors-api.conf) |
| 跑 Docker 全栈示例 | [`docker/docker-compose.fullstack.yml`](docker/docker-compose.fullstack.yml) |
| 新服务器做安全基线 | [`server-security/checklist.md`](server-security/checklist.md), [`server-security/ubuntu-baseline.sh`](server-security/ubuntu-baseline.sh) |
| 排查部署失败 | [`docs/troubleshooting.md`](docs/troubleshooting.md), [`docs/quick-command-map.md`](docs/quick-command-map.md) |

## 目录结构

```text
student-deploy-kit/
├─ nginx-configs/        # 静态站点、反向代理、HTTPS、跨域、安全头
├─ springboot-deploy/    # 部署脚本、systemd、日志切割、健康检查
├─ frontend-deploy/      # Vue/React/静态站点部署脚本和 Actions 示例
├─ server-security/      # Ubuntu 防火墙、fail2ban、安全清单
├─ docker/               # Spring Boot、前端、全栈 Compose 示例
├─ docs/                 # 教程、FAQ、故障排查、命令速查
├─ examples/             # 用于上线测试的极简静态页
└─ scripts/validate.sh   # 模板校验脚本
```

## 极简示例

仓库里带了一个静态测试页：

```bash
sudo bash frontend-deploy/deploy-static.sh \
  --source examples/static-site \
  --target /var/www/demo-web
```

然后启用 [`nginx-configs/static-site.conf`](nginx-configs/static-site.conf)，并 reload Nginx。

## 安全提醒

- 任何 `sudo` 脚本运行前都要先读一遍。
- 替换 `example.com`、`/opt/demo-api`、`/var/www/demo-web` 这类占位符。
- 不要提交 `.env`、私钥、SSH key、数据库密码、Cookie、Token。
- reload Nginx 前先执行 `sudo nginx -t`。
- 除非你很确定，否则 Spring Boot 应放在 Nginx 后面，不直接暴露公网端口。

## 校验模板

```bash
bash scripts/validate.sh
docker compose -f docker/docker-compose.fullstack.yml config
```

GitHub Actions 会在每次 push 和 pull request 时执行模板校验。

## 适合贡献的方向

这个项目适合通过一个个小模板慢慢长大：

- Node.js + PM2 + Nginx 部署。
- FastAPI + systemd + Nginx 部署。
- 阿里云 / 腾讯云 VPS 教程。
- Caddy 配置。
- 宝塔面板迁移说明。
- Windows Server 部署说明。

开放 issue：<https://github.com/aolingge/student-deploy-kit/issues>

## License

MIT
