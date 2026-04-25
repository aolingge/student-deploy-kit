# Server Security Checklist

Use this before exposing a student project or personal site to the internet.

## First 15 Minutes

- Create a non-root user.
- Add your SSH public key.
- Disable password SSH login after confirming key login works.
- Enable firewall ports: SSH, HTTP, HTTPS.
- Install security updates.
- Install fail2ban.
- Use strong database passwords.
- Do not run Spring Boot as root.

## Before Production

- Enable HTTPS.
- Keep `.env` files outside Git.
- Rotate logs.
- Configure backups for database and uploaded files.
- Check `sudo nginx -t` before reloading Nginx.
- Check `systemctl status your-app` after deployment.

## Useful Commands

```bash
sudo ufw status verbose
sudo systemctl status nginx
sudo journalctl -u demo-api -n 100 --no-pager
sudo tail -f /var/log/nginx/error.log
```
