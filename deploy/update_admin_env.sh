#!/bin/bash
# Скрипт для очистки env-переменных Admin после первого успешного входа.
# Запускать на VPS после первого логина Admin:
#
#   sudo bash /opt/family_chat/update_admin_env.sh
#
# Это предотвращает повторную попытку пересоздать Admin при каждом перезапуске сервиса.

set -e

SERVICE_FILE="/etc/systemd/system/family-chat.service"

if [ ! -f "$SERVICE_FILE" ]; then
  echo "ERROR: Service file not found: $SERVICE_FILE"
  exit 1
fi

echo "Clearing ADMIN_EMAIL and ADMIN_INITIAL_PASSWORD from systemd service..."

# Очистить значения переменных (оставить пустыми для совместимости)
sed -i 's/Environment="ADMIN_EMAIL=.*"/Environment="ADMIN_EMAIL="/' "$SERVICE_FILE"
sed -i 's/Environment="ADMIN_INITIAL_PASSWORD=.*"/Environment="ADMIN_INITIAL_PASSWORD="/' "$SERVICE_FILE"

systemctl daemon-reload

echo "Done. Admin env variables cleared from $SERVICE_FILE"
echo ""
echo "Reload the service to apply changes:"
echo "  sudo systemctl restart family-chat"
