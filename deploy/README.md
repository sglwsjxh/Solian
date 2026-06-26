# Solian Flutter Web 部署指南

自托管的 Flutter Web 构建和部署流程。

## 前置条件

- Flutter SDK 3.x（与项目版本一致）
- 自有域名（如 `akiromusic.art`）
- 后端 DysonNetwork 已部署并可访问

## 构建

在项目根目录运行：

```bash
chmod +x deploy/build-web.sh
./deploy/build-web.sh
```

或直接使用 Flutter 命令：

```bash
flutter build web --release \
  --dart-define=API_BASE_URL=https://api.你的域名
```

构建产物在 `build/web/` 目录下。

## Nginx 配置

将 `build/web/` 目录放到 Nginx 的 web 根目录，并使用以下配置模板（按需修改域名）：

```nginx
server {
    listen 80;
    server_name web.你的域名;

    root /var/www/solian-web;
    index index.html;

    # Flutter Web 路由支持
    location / {
        try_files $uri $uri/ /index.html;
    }

    # 静态资源缓存
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff2?)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Gzip 压缩
    gzip on;
    gzip_types text/plain application/json application/javascript text/css;
    gzip_min_length 1000;
}
```

配置路径：`deploy/nginx/solian-web.conf` 放入 Nginx 的 `sites-enabled/` 或等效目录。

## Cloudflare Tunnel

HTTPS 由 Cloudflare Tunnel 处理，无需自行配置 SSL：

1. 在 Cloudflare Zero Trust 面板创建 Tunnel
2. 公共主机名指向 `web.你的域名`，端口 80，Nginx 服务
3. Tunnel 自动提供 SSL 终止

参考：[Cloudflare Tunnel 文档](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/)

## 部署步骤

1. **构建**：`./deploy/build-web.sh`
2. **上传**：将 `build/web/` 复制到服务器 Nginx 根目录
3. **重载 Nginx**：`sudo nginx -t && sudo systemctl reload nginx`
4. **配置 Tunnel**：确保 Cloudflare Tunnel 指向正确的 Nginx 端口

## CI/CD（GitHub Actions）

`.github/workflows/build.yml` 中的 `web` job 会在推送 tag 时自动构建并上传到 GitHub Releases：

```yaml
- name: Build Flutter Web
  run: |
    flutter build web --release \
      --dart-define=API_BASE_URL=https://api.你的域名
```

发布产物可通过 Cloudflare R2 或 GitHub Releases 分发。

## 常见问题

**Q: 刷新页面 404？**
A: 检查 Nginx `try_files` 配置是否正确指向 `index.html`。

**Q: API 连接失败？**
A: 确认 `API_BASE_URL` 的 Dart-define 与后端实际地址一致，且后端 CORS 允许你的域名。

**Q: 构建体积过大？**
A: 检查 `build/web/assets/` 是否包含了不必要的资源，考虑裁剪 `assets/` 目录。
