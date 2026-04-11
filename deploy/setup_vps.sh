#!/bin/bash
# ============================================================
# FamilyChat — Подготовка нового VPS (выполняется от root)
# ============================================================
# Этот скрипт делает ТОЛЬКО одно: прописывает SSH-ключ для root,
# чтобы GitHub Actions мог зайти и всё остальное сделать сам.
#
# После запуска этого скрипта — запустите GitHub Actions workflow
# "First Deploy — VPS Setup" и он автоматически:
#   - установит пакеты (nginx, postgresql, certbot)
#   - создаст БД и пользователя
#   - скопирует SSH-ключ для USER_NAME
#   - настроит systemd, nginx, SSL
#   - скомпилирует и задеплоит сервер и Flutter Web
#
# ────────────────────────────────────────────────────────────────
# КАК СГЕНЕРИРОВАТЬ SSH-КЛЮЧ (одна пара для root и USER_NAME):
#
#   На локальной машине:
#     ssh-keygen -t ed25519 -C "family-chat-deploy" -f ~/.ssh/family_chat_deploy
#
#   Это создаст два файла:
#     ~/.ssh/family_chat_deploy      — приватный ключ → GitHub Secret VPS_SERVER_KEY
#     ~/.ssh/family_chat_deploy.pub  — публичный ключ → прописать на VPS (см. ниже)
#
# ────────────────────────────────────────────────────────────────
# ИСПОЛЬЗОВАНИЕ:
#
#   1. Скопируйте публичный ключ:
#        cat ~/.ssh/family_chat_deploy.pub
#
#   2. Зайдите на VPS как root и запустите этот скрипт,
#      передав публичный ключ как аргумент:
#
#        ssh root@<VPS_IP>
#        bash <(curl -fsSL https://raw.githubusercontent.com/alex-pf/family_chat/main/deploy/setup_vps.sh) \
#          "ВАШ_ПУБЛИЧНЫЙ_КЛЮЧ"
#
#   3. Добавьте в GitHub Secrets:
#        VPS_SERVER_KEY     — содержимое ~/.ssh/family_chat_deploy (приватный ключ)
#        VPS_IP             — IP этого сервера
#        USER_NAME          — имя вашего пользователя (например: devuser)
#        SERVER_DOMAIN      — домен (например: chat.example.com)
#        DB_PASSWORD        — пароль PostgreSQL (придумайте сами)
#        SERVICE_SECRET     — openssl rand -hex 32
#        EMAIL_PEPPER       — openssl rand -hex 32
#        JWT_PRIVATE_KEY    — openssl rand -hex 64
#        JWT_REFRESH_PEPPER — openssl rand -hex 32
#
#   4. Запустите в GitHub:
#        Actions → "First Deploy — VPS Setup" → Run workflow
#        Укажите: домен, admin email, начальный пароль
#
# ============================================================

set -e

PUBLIC_KEY="$1"

if [ -z "$PUBLIC_KEY" ]; then
  echo "Использование: bash setup_vps.sh \"ВАШ_ПУБЛИЧНЫЙ_SSH_КЛЮЧ\""
  echo ""
  echo "Пример:"
  echo "  bash setup_vps.sh \"ssh-ed25519 AAAA... family-chat-deploy\""
  exit 1
fi

echo "=== FamilyChat — Регистрация SSH-ключа на VPS ==="

# Прописать ключ для root
mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys

# Добавить только если ещё нет
grep -qF "$PUBLIC_KEY" /root/.ssh/authorized_keys || \
  echo "$PUBLIC_KEY" >> /root/.ssh/authorized_keys

echo "  => SSH ключ добавлен в /root/.ssh/authorized_keys"
echo ""
echo "Теперь запустите GitHub Actions workflow:"
echo "  Actions → 'First Deploy — VPS Setup' → Run workflow"
echo ""
