# FamilyChat

Семейный чат с аутентификацией, ролевой моделью и расширяемой архитектурой.

**Стек:** Flutter 3.32.8 · Serverpod 3.4.6 · PostgreSQL · GitHub Actions  
**Frontend:** GitHub Pages (Flutter Web / WASM)  
**Backend:** VPS, systemd-сервис, nginx reverse proxy, Let's Encrypt SSL

---

## Структура репозитория

```
family_chat_sp/
├── family_chat_sp_server/     # Dart-бэкенд (Serverpod)
│   ├── bin/main.dart
│   ├── lib/
│   ├── config/
│   │   └── production.yaml    # Конфиг сервера (домен, БД, порты)
│   └── migrations/            # Миграции БД (Serverpod built-in)
├── family_chat_sp_client/     # Сгенерированный Dart-клиент
├── family_chat_sp_flutter/    # Flutter-приложение
├── deploy/
│   ├── setup_vps.sh           # Регистрация SSH-ключа на VPS (только это!)
│   └── update_admin_env.sh    # Обновление env для admin-пользователя
└── .github/workflows/
    ├── first_deploy.yml       # Первичная настройка нового сервера
    └── deploy.yml             # Обычный деплой при push в main
```

---

## GitHub Secrets

Все секреты хранятся в **Settings → Secrets and variables → Actions**.

| Секрет | Описание |
|--------|----------|
| `VPS_IP` | IP-адрес VPS |
| `VPS_SERVER_KEY` | Приватный SSH-ключ (один для `root` и `USER_NAME`) |
| `USER_NAME` | Имя deploy-пользователя на сервере (например: `devuser`) |
| `SERVER_DOMAIN` | Домен (например: `chat.example.com`) |
| `ADMIN_EMAIL` | Email первого администратора |
| `ADMIN_INITIAL_PASSWORD` | Начальный пароль администратора |
| `DB_PASSWORD` | Пароль PostgreSQL для `family_chat_user` |
| `SERVICE_SECRET` | `openssl rand -hex 32` |
| `EMAIL_PEPPER` | `openssl rand -hex 32` |
| `JWT_PRIVATE_KEY` | `openssl rand -hex 64` |
| `JWT_REFRESH_PEPPER` | `openssl rand -hex 32` |

> `ADMIN_EMAIL` и `ADMIN_INITIAL_PASSWORD` также передаются как **inputs** при запуске `first_deploy.yml` — они попадают в `ExecStart` systemd-сервиса как переменные окружения.

---

## Деплой с нуля (новый сервер)

### Шаг 1 — Сгенерировать SSH-ключ

```bash
# На локальной машине
ssh-keygen -t ed25519 -C "family-chat-deploy" -f ~/.ssh/family_chat_deploy
```

Это создаст:
- `~/.ssh/family_chat_deploy` — **приватный ключ** → GitHub Secret `VPS_SERVER_KEY`
- `~/.ssh/family_chat_deploy.pub` — **публичный ключ** → прописать на VPS (шаг 2)

### Шаг 2 — Зарегистрировать ключ на VPS

Зайдите на сервер как `root` и выполните скрипт, передав публичный ключ:

```bash
ssh root@<VPS_IP>

bash <(curl -fsSL https://raw.githubusercontent.com/alex-pf/family_chat/main/deploy/setup_vps.sh) \
  "$(cat ~/.ssh/family_chat_deploy.pub)"
```

Скрипт делает ровно одно: добавляет ключ в `/root/.ssh/authorized_keys`.  
Дальше всё делает GitHub Actions.

> **Примечание:** один и тот же ключ работает для `root` и `USER_NAME`.  
> Workflow `first_deploy.yml` автоматически скопирует `authorized_keys` из `root` в домашнюю директорию `USER_NAME`.

### Шаг 3 — Добавить GitHub Secrets

Добавьте все секреты из таблицы выше в **Settings → Secrets and variables → Actions**.

Для генерации случайных значений:
```bash
openssl rand -hex 32   # для SERVICE_SECRET, EMAIL_PEPPER, JWT_REFRESH_PEPPER
openssl rand -hex 64   # для JWT_PRIVATE_KEY
```

### Шаг 4 — Запустить First Deploy

В GitHub: **Actions → "First Deploy — VPS Setup" → Run workflow**

Заполните inputs:
- **Домен сервера** — например `chat.example.com`
- **Email администратора**
- **Начальный пароль администратора** (будет изменён при первом входе)

Workflow выполняет 4 последовательных джоба:

| Джоб | От имени | Что делает |
|------|----------|------------|
| `bootstrap-root` | `root` | Устанавливает пакеты (nginx, postgresql, certbot, ufw), создаёт БД `family_chat_db` и пользователя `family_chat_user`, копирует SSH-ключ для `USER_NAME`, настраивает sudoers и firewall |
| `setup-vps` | `USER_NAME` | Создаёт директории `~/family_chat/`, записывает `production.yaml`, создаёт и включает systemd-сервис `family-chat`, конфигурирует nginx |
| `obtain-ssl` | `USER_NAME` | Получает SSL-сертификат Let's Encrypt через certbot (standalone), перезапускает nginx |
| `first-server-deploy` + `first-flutter-deploy` | `USER_NAME` | Компилирует сервер и Flutter Web параллельно, деплоит сервер на VPS, деплоит Flutter на GitHub Pages |

После успешного завершения — приложение доступно по домену.

---

## Обычный деплой (push в main)

Workflow `deploy.yml` запускается автоматически при каждом `git push` в ветку `main`.

Параллельно:
1. **Flutter Web** — собирается (WASM, `--dart-define=SERVER_URL=https://...`) и деплоится на GitHub Pages
2. **Serverpod Server** — компилируется в бинарник, копируется на VPS, сервис перезапускается

Миграции применяются автоматически при старте сервера (флаг `--apply-migrations` в `ExecStart`).

---

## Первый вход в приложение

После деплоя:

1. Откройте `https://<YOUR_GITHUB_USERNAME>.github.io/family_chat/`
2. Войдите с `ADMIN_EMAIL` и `ADMIN_INITIAL_PASSWORD`
3. Система предложит сменить пароль при первом входе (`mustChangePassword = true`)
4. После смены пароля откроется полный интерфейс с системным чатом и панелью администратора

---

## Архитектура

### Сервер

- **Порты:** 8080 (API), 8081 (Insights), 8082 (Web)
- **Nginx** проксирует HTTPS → `http://127.0.0.1:8080`
  - `proxy_pass http://127.0.0.1:8080` (не `localhost` — во избежание проблем с IPv6)
  - `map $http_upgrade $connection_upgrade` — корректная обработка WebSocket и обычных HTTP-запросов
- **БД:** `family_chat_db` / `family_chat_user`
- **Директория приложения:** `~/family_chat/` (т.е. `/home/<USER_NAME>/family_chat/`)
- **Systemd-сервис:** `family-chat`

### Аутентификация

- Email + пароль через Serverpod Auth
- Access token + refresh token (refresh протухает через **1 месяц неактивности**)
- Google/Apple Sign-In — не реализованы, но архитектурно заложены
- «Спросить администратора» — одноразовый токен на 15 минут

### Роли пользователей

`superAdmin` · `admin` · `moderator` · `user` · `guest` · `banned` · `pendingApproval`

### Первый администратор

При первом старте сервер читает из env:
- `ADMIN_EMAIL` — email администратора
- `ADMIN_INITIAL_PASSWORD` — начальный пароль

Эти переменные попадают в systemd через `ExecStart` и устанавливаются в `first_deploy.yml` inputs.

### Расширяемость

Архитектура рассчитана на рост:
- Flutter Web сейчас → нативные iOS/Android/Desktop в будущем
- Встроенные игры и дополнительные функции
- Миграции БД — через встроенный механизм Serverpod

---

## Структура сервера на VPS

```
~/family_chat/
├── family_chat_server_bin   # Скомпилированный бинарник (Dart AOT)
├── config/
│   ├── production.yaml      # Конфиг (порты, БД, домен)
│   └── passwords.yaml       # Секреты (создаётся workflow, chmod 600)
├── migrations/              # Файлы миграций Serverpod
└── data/                    # Данные приложения
```

---

## Полезные команды

```bash
# Статус сервиса
sudo systemctl status family-chat

# Логи в реальном времени
sudo journalctl -u family-chat -f

# Последние 50 строк логов
sudo journalctl -u family-chat -n 50 --no-pager

# Перезапуск вручную
sudo systemctl restart family-chat

# Проверка nginx
sudo nginx -t && sudo systemctl reload nginx

# Проверка подключения к API
curl -s https://<DOMAIN>/

# Посмотреть таблицы БД
sudo -u postgres psql family_chat_db -c "\dt"
```

---

## Диагностика

### Сервис не запускается

```bash
sudo journalctl -u family-chat -n 50 --no-pager
```

Частые причины:
- Неверный пароль БД → проверьте `~/family_chat/config/passwords.yaml`
- Неверное имя БД/пользователя → проверьте `~/family_chat/config/production.yaml` (должно быть `family_chat_db` / `family_chat_user`)
- Бинарник без прав на исполнение → `chmod +x ~/family_chat/family_chat_server_bin`

### nginx возвращает «No method name specified»

Проверьте наличие `map $http_upgrade $connection_upgrade` в конфиге nginx и что заголовок `Connection` установлен в `$connection_upgrade` (не хардкодом `"upgrade"`).

### Ошибка подключения в браузере (ERR_TIMED_OUT)

Убедитесь, что `proxy_pass` указывает на `http://127.0.0.1:8080`, а не на `localhost` — на некоторых серверах `localhost` резолвится в IPv6-адрес `[::1]`, что вызывает таймаут.

### Таблицы не создались после миграции

Убедитесь, что бинарник запускается с флагом `--apply-migrations` (прописано в `ExecStart` systemd-сервиса).

---

## Ссылки

- **Приложение:** https://alex-pf.github.io/family_chat/
- **Serverpod docs:** https://docs.serverpod.dev
- **Flutter docs:** https://docs.flutter.dev
