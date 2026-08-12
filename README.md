# 企业出海签证办理工作台

参考“出海签证工作台”复现的零依赖响应式单页应用。数据默认保存在浏览器 `localStorage`，适合内部演示和需求确认。

## 本地启动

```powershell
npm start
```

访问 `http://localhost:8080`。

## Docker 部署

```bash
docker build -t visa-dashboard .
docker run -d --restart unless-stopped --name visa-dashboard -p 80:8080 visa-dashboard
```

也可在 Windows 开发机直接运行一键脚本：

```powershell
.\deploy.ps1 -Server "服务器公网 IP" -User "root" -IdentityFile "C:\path\to\private-key.pem"
```

生产使用建议在腾讯云 CVM 安全组开放 80/443，域名解析至服务器公网 IP，并通过 Nginx/Caddy 配置 HTTPS。当前版本是前端演示版；正式承载员工与护照数据前，应接入公司身份认证、后端数据库、权限控制、审计日志及加密存储。
