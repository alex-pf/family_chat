#!/bin/bash
# ============================================================
# FamilyChat — Подготовка VPS (выполняется один раз от root)
# ============================================================
# Этот скрипт делает только то, что требует root и не может
# быть сделано через GitHub Actions (devuser не имеет sudo apt).
#
# Всё остальное (nginx config, systemd, SSL, DB, первый деплой)
# автоматизировано в .github/workflows/first_deploy.yml
#
# Использование:
#   ssh root@<VPS_IP>
#   bash <(curl -fsSL https://raw.githubusercontent.com/alex-pf/family_chat/main/deploy/setup_vps.sh) <domain>
#
# Пример:
#   bash setup_vps.sh chat.example.com

set -e

DOMAIN="${1:-YOUR_DOMAIN.COM}"

echo "=== FamilyChat VPS Pre-Setup ==="
echo "Domain: $DOMAIN"
echo ""

# ────────────────────────────────────────────────────────────────
# 1. Системные пакеты
# ────────────────────────────────────────────────────────────────
echo "--- [1/4] Installing packages ---"
apt-get update -qq
apt-get install -y -qq \
  nginx postgresql postgresql-contrib \
  certbot python3-certbot-nginx \
  curl gnupg ufw

# ────────────────────────────────────────────────────────────────
# 2. Пользователь devuser (если ещё не существует)
# ────────────────────────────────────────────────────────────────
echo "--- [2/4] Ensuring devuser exists ---"
if ! id devuser &>/dev/null; then
  useradd -m -s /bin/bash devuser
  echo "  => User 'devuser' created"
else
  echo "  => User 'devuser' already exists"
fi

DEV_HOME=$(getent passwd devuser | cut -d: -f6)

# Убедиться что .ssh настроен
mkdir -p "$DEV_HOME/.ssh"
touch "$DEV_HOME/.ssh/authorized_keys"
chmod 700 "$DEV_HOME/.ssh"
chmod 600 "$DEV_HOME/.ssh/authorized_keys"
chown -R devuser:devuser "$DEV_HOME/.ssh"

echo ""
echo "  *** ВАЖНО: Добавьте публичный SSH-ключ в $DEV_HOME/.ssh/authorized_keys ***"
echo "  Приватный ключ должен быть в GitHub Secret VPS_SERVER_KEY"
echo ""

# ────────────────────────────────────────────────────────────────
# 3. Firewall
# ────────────────────────────────────────────────────────────────
echo "--- [3/4] Configuring firewall ---"
ufw allow OpenSSH
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable
echo "  => UFW: SSH + 80 + 443 открыты"

# ────────────────────────────────────────────────────────────────
# 4. PostgreSQL — создать пользователя и БД
#    (CI не может этого сделать, т.к. нужен доступ к postgres)
# ────────────────────────────────────────────────────────────────
echo "--- [4/4] PostgreSQL setup ---"

# Попросить пароль для БД
echo ""
echo "Введите пароль для пользователя family_chat_user PostgreSQL"
echo "(он же GitHub Secret DB_PASSWORD):"
read -s DB_PASS
echo ""

sudo -u postgres psql << SQL
DO \$\$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'family_chat_user') THEN
    CREATE USER family_chat_user WITH PASSWORD '$DB_PASS';
    RAISE NOTICE 'User family_chat_user created';
  ELSE
    ALTER USER family_chat_user WITH PASSWORD '$DB_PASS';
    RAISE NOTICE 'User family_chat_user password updated';
  END IF;
END
\$\$;

SELECT 'CREATE DATABASE family_chat_db OWNER family_chat_user'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'family_chat_db')\gexec

GRANT ALL PRIVILEGES ON DATABASE family_chat_db TO family_chat_user;
SQL

echo "  => PostgreSQL ready: family_chat_db / family_chat_user"

# ────────────────────────────────────────────────────────────────
# Готово — дальше всё через GitHub Actions
# ────────────────────────────────────────────────────────────────
echo ""
echo "============================================"
echo "=== Pre-Setup Complete! ==="
echo "============================================"
echo ""
echo "Следующие шаги:"
echo ""
echo "1. Добавьте публичный SSH-ключ:"
echo "   echo 'ВАШ_ПУБЛИЧНЫЙ_КЛЮЧ' >> $DEV_HOME/.ssh/authorized_keys"
echo ""
echo "2. Убедитесь что все GitHub Secrets добавлены:"
echo "   VPS_IP              — IP этого сервера"
echo "   VPS_SERVER_KEY      — приватный SSH-ключ devuser"
echo "   SERVER_DOMAIN       — $DOMAIN"
echo "   DB_PASSWORD         — пароль который вы только что ввели"
echo "   SERVICE_SECRET      — openssl rand -hex 32"
echo "   EMAIL_PEPPER        — openssl rand -hex 32"
echo "   JWT_PRIVATE_KEY     — openssl rand -hex 64"
echo "   JWT_REFRESH_PEPPER  — openssl rand -hex 32"
echo "   ADMIN_EMAIL         — email первого администратора"
echo "   ADMIN_INITIAL_PASSWORD — начальный пароль администратора"
echo ""
echo "3. Запустите GitHub Actions workflow:"
echo "   Actions → 'First Deploy — VPS Setup' → Run workflow"
echo "   Укажите домен: $DOMAIN"
echo ""
