#!/bin/bash
# Скрипт первоначальной настройки VPS для FamilyChat
# Запускать от root: bash setup_vps.sh <your-domain.com>
#
# Пример: bash setup_vps.sh chat.example.com

set -e

DOMAIN="${1:-YOUR_DOMAIN.COM}"

echo "=== FamilyChat VPS Setup ==="
echo "Domain: $DOMAIN"
echo ""

# 1. Установить зависимости
echo "--- [1/9] Installing dependencies ---"
apt-get update
apt-get install -y nginx postgresql postgresql-contrib certbot python3-certbot-nginx curl gnupg

# 2. Установить Dart SDK
echo "--- [2/9] Installing Dart SDK ---"
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/dart.gpg
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' > /etc/apt/sources.list.d/dart_stable.list
apt-get update
apt-get install -y dart

# 3. Создать пользователя devuser
echo "--- [3/9] Creating devuser user ---"
useradd -m -s /bin/bash devuser || echo "User 'devuser' already exists"

DEV_HOME=$(getent passwd devuser | cut -d: -f6)

mkdir -p "$DEV_HOME/.ssh"
touch "$DEV_HOME/.ssh/authorized_keys"
chmod 700 "$DEV_HOME/.ssh"
chmod 600 "$DEV_HOME/.ssh/authorized_keys"
chown -R devuser:devuser "$DEV_HOME/.ssh"

echo "  => devuser user ready. Add your public key to $DEV_HOME/.ssh/authorized_keys!"
echo ""

# 4. Создать директории приложения
echo "--- [4/9] Creating application directories ---"
mkdir -p "$DEV_HOME/family_chat/config"
mkdir -p "$DEV_HOME/family_chat/data"
mkdir -p "$DEV_HOME/family_chat/migrations"
chown -R devuser:devuser "$DEV_HOME/family_chat"

# Разрешить devuser перезапускать сервис без пароля sudo (только family-chat)
echo "devuser ALL=(ALL) NOPASSWD: /bin/systemctl restart family-chat, /bin/systemctl status family-chat, /bin/systemctl start family-chat, /bin/systemctl stop family-chat" \
  > /etc/sudoers.d/devuser-family-chat
chmod 440 /etc/sudoers.d/devuser-family-chat

# 5. Настроить PostgreSQL
echo "--- [5/9] Configuring PostgreSQL ---"
# Генерируем случайный пароль БД (можно заменить на свой)
DB_PASS=$(openssl rand -base64 24 | tr -dc 'a-zA-Z0-9' | head -c 32)
sudo -u postgres psql << SQL
DO \$\$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'family_chat_user') THEN
    CREATE USER family_chat_user WITH PASSWORD '$DB_PASS';
  END IF;
END
\$\$;
CREATE DATABASE family_chat_db OWNER family_chat_user;
GRANT ALL PRIVILEGES ON DATABASE family_chat_db TO family_chat_user;
SQL
echo ""
echo "  *** PostgreSQL password for family_chat_user: $DB_PASS ***"
echo "  Add this as GitHub Secret DB_PASSWORD and in passwords.yaml!"
echo ""

# 6. Создать production.yaml
echo "--- [6/9] Creating production.yaml ---"
cat > "$DEV_HOME/family_chat/config/production.yaml" << EOF
apiServer:
  port: 8080
  publicHost: $DOMAIN
  publicPort: 443
  publicScheme: https

insightsServer:
  port: 8081
  publicHost: insights.$DOMAIN
  publicPort: 443
  publicScheme: https

webServer:
  port: 8082
  publicHost: $DOMAIN
  publicPort: 443
  publicScheme: https

database:
  host: localhost
  port: 5432
  name: family_chat_db
  user: family_chat_user
  requireSsl: false

redis:
  enabled: false

maxRequestSize: 25165824  # 24 MB

sessionLogs:
  consoleEnabled: true
EOF
chown devuser:devuser "$DEV_HOME/family_chat/config/production.yaml"
echo "  => $DEV_HOME/family_chat/config/production.yaml created"

# 7. Создать placeholder passwords.yaml (будет перезаписан CI/CD)
echo "--- [7/9] Creating placeholder passwords.yaml ---"
cat > "$DEV_HOME/family_chat/config/passwords.yaml" << EOF
# ВНИМАНИЕ: Этот файл будет перезаписан CI/CD при каждом деплое.
# Не редактируйте вручную — изменения будут потеряны.
production:
  database: 'PLACEHOLDER_SET_BY_CICD'
  serviceSecret: 'PLACEHOLDER_SET_BY_CICD'
  emailSecretHashPepper: 'PLACEHOLDER_SET_BY_CICD'
  jwtHmacSha512PrivateKey: 'PLACEHOLDER_SET_BY_CICD'
  jwtRefreshTokenHashPepper: 'PLACEHOLDER_SET_BY_CICD'
EOF
chown devuser:devuser "$DEV_HOME/family_chat/config/passwords.yaml"
chmod 600 "$DEV_HOME/family_chat/config/passwords.yaml"

# 8. Создать systemd service
echo "--- [8/9] Creating systemd service ---"
cat > /etc/systemd/system/family-chat.service << EOF
[Unit]
Description=FamilyChat Server (Serverpod)
After=network.target postgresql.service
Wants=postgresql.service

[Service]
Type=simple
User=devuser
WorkingDirectory=$DEV_HOME/family_chat
ExecStart=$DEV_HOME/family_chat/family_chat_server_bin --mode production --apply-migrations
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal
SyslogIdentifier=family-chat

# Serverpod passwords (YAML-файл, перезаписывается CI/CD)
# Serverpod также поддерживает env vars вида SERVERPOD_PASSWORD_<key>
EnvironmentFile=-$DEV_HOME/family_chat/config/passwords.env

# Admin seeding — заполните перед ПЕРВЫМ запуском, затем очистите через update_admin_env.sh
Environment="ADMIN_EMAIL="
Environment="ADMIN_INITIAL_PASSWORD="

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable family-chat
echo "  => systemd service 'family-chat' enabled"

# 9. Nginx config
echo "--- [9/9] Configuring Nginx ---"
cat > /etc/nginx/sites-available/family-chat << EOF
server {
    listen 80;
    server_name $DOMAIN;

    # Redirect HTTP to HTTPS
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name $DOMAIN;

    # SSL управляется certbot
    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;

    # WebSocket upgrade support (для Serverpod streaming)
    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_read_timeout 86400s;
        proxy_send_timeout 86400s;

        # Увеличенный буфер для загрузки файлов (до 24 MB)
        client_max_body_size 25m;
        proxy_buffer_size 128k;
        proxy_buffers 4 256k;
        proxy_busy_buffers_size 256k;
    }
}
EOF

# Удалить дефолтный сайт если есть
rm -f /etc/nginx/sites-enabled/default

ln -sf /etc/nginx/sites-available/family-chat /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx
echo "  => Nginx configured for $DOMAIN"

echo ""
echo "============================================"
echo "=== Setup Complete! ==="
echo "============================================"
echo ""
echo "Remaining manual steps:"
echo ""
echo "1. Add your SSH public key to $DEV_HOME/.ssh/authorized_keys"
echo "   (The private key must match GitHub Secret VPS_SERVER_KEY_DEVUSER)"
echo ""
echo "2. Set admin credentials in systemd service (for first run):"
echo "   Edit /etc/systemd/system/family-chat.service"
echo "   Set: Environment=\"ADMIN_EMAIL=admin@example.com\""
echo "   Set: Environment=\"ADMIN_INITIAL_PASSWORD=SecurePassword123\""
echo "   Then: systemctl daemon-reload"
echo ""
echo "3. Get SSL certificate:"
echo "   certbot --nginx -d $DOMAIN"
echo ""
echo "4. Add GitHub Secrets in your repository settings:"
echo "   DB_PASSWORD        = $DB_PASS"
echo "   SERVICE_SECRET     = (generate: openssl rand -hex 32)"
echo "   EMAIL_PEPPER       = (generate: openssl rand -hex 32)"
echo "   JWT_PRIVATE_KEY    = (generate: openssl rand -hex 64)"
echo "   JWT_REFRESH_PEPPER = (generate: openssl rand -hex 32)"
echo ""
echo "5. Push to main branch to trigger first deployment via GitHub Actions"
echo ""
echo "6. After first successful login as Admin:"
echo "   bash /path/to/devuser/update_admin_env.sh"
echo ""
