# FamilyChat

Семейный чат с аутентификацией, ролевой моделью и расширяемой архитектурой.

**Стек:** Flutter 3.32.8 · Serverpod 3.4.6 · PostgreSQL · Docker · GitHub Actions  
**Frontend:** GitHub Pages (Flutter Web / WASM)  
**Backend:** VPS, Docker Compose (app + db + nginx + certbot), Let's Encrypt SSL

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
├── Dockerfile                 # Многоэтапная сборка сервера (dart → debian-slim)
├── docker-compose.yml         # Стек: app + db + nginx + certbot
├── nginx/
│   ├── nginx.conf             # HTTP-only (для получения сертификата)
│   └── nginx.ssl.conf         # Полная конфигурация с SSL
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
| `VPS_SERVER_KEY` | Приватный SSH-ключ для `USER_NAME` |
| `USER_NAME` | Имя deploy-пользователя на сервере (например: `devuser`) |
| `SERVER_DOMAIN` | Домен (например: `chat.example.com`) |
| `ADMIN_EMAIL` | Email первого администратора |
| `ADMIN_INITIAL_PASSWORD` | Начальный пароль администратора |
| `DB_PASSWORD` | Пароль PostgreSQL для `family_chat_user` |
| `SERVICE_SECRET` | `openssl rand -hex 32` |
| `EMAIL_PEPPER` | `openssl rand -hex 32` |
| `JWT_PRIVATE_KEY` | `openssl rand -hex 64` |
| `JWT_REFRESH_PEPPER` | `openssl rand -hex 32` |

> `ADMIN_EMAIL` и `ADMIN_INITIAL_PASSWORD` также передаются как **inputs** при запуске `first_deploy.yml` — они попадают в `.env` файл Docker Compose на сервере.

---

## Деплой с нуля (новый сервер)

### Шаг 1 — Подготовить сервер вручную (один раз)

Подключитесь к VPS и установите Docker:

```bash
# Установка Docker
curl -fsSL https://get.docker.com | sh

# Добавить своего пользователя в группу docker (замените devuser на своё имя)
sudo usermod -aG docker devuser

# Переподключиться по SSH, чтобы группа вступила в силу
exit
ssh devuser@<VPS_IP>

# Проверить
docker --version
docker compose version
```

> После этого шага root больше не нужен. Всё остальное делает GitHub Actions от имени `USER_NAME`.

### Шаг 2 — Сгенерировать SSH-ключ

```bash
# На локальной машине
ssh-keygen -t ed25519 -C "family-chat-deploy" -f ~/.ssh/family_chat_deploy
```

Добавьте публичный ключ на сервер:
```bash
ssh-copy-id -i ~/.ssh/family_chat_deploy.pub devuser@<VPS_IP>
# или вручную:
# cat ~/.ssh/family_chat_deploy.pub >> ~/.ssh/authorized_keys
```

Приватный ключ (`~/.ssh/family_chat_deploy`) → GitHub Secret `VPS_SERVER_KEY`.

### Шаг 3 — Добавить GitHub Secrets

Добавьте все секреты из таблицы выше в **Settings → Secrets and variables → Actions**.

Для генерации случайных значений:
```bash
openssl rand -hex 32   # для SERVICE_SECRET, EMAIL_PEPPER, JWT_REFRESH_PEPPER
openssl rand -hex 64   # для JWT_PRIVATE_KEY
```

### Шаг 4 — Запустить First Deploy

В GitHub: **Actions → "First Deploy" → Run workflow**

Заполните inputs:
- **Домен сервера** — например `chat.example.com`
- **Email администратора**
- **Начальный пароль администратора** (будет изменён при первом входе)

Workflow выполняет джобы:

| Джоб | Что делает |
|------|------------|
| `setup-config` | Создаёт `~/family_chat/`, пишет `production.yaml`, `passwords.yaml`, копирует nginx и docker-compose конфиги |
| `build-and-push` | Собирает Docker-образ сервера, пушит в GitHub Container Registry (`ghcr.io`) |
| `obtain-ssl` | Запускает nginx (HTTP), получает Let's Encrypt сертификат через certbot, переключает на SSL-конфиг |
| `deploy` | `docker compose pull && up -d` — поднимает весь стек (app + db + nginx + certbot) |
| `first-flutter-deploy` | Собирает Flutter Web (WASM), деплоит на GitHub Pages |

После успешного завершения — приложение доступно по домену.

---

## Обычный деплой (push в main)

Workflow `deploy.yml` запускается автоматически при каждом `git push` в ветку `main`.

Параллельно:
1. **Flutter Web** — собирается (WASM, `--dart-define=SERVER_URL=https://...`) и деплоится на GitHub Pages
2. **Serverpod Server** — собирается в Docker-образ, пушится в `ghcr.io`, на сервере выполняется `docker compose pull && up -d`

Миграции применяются автоматически при старте контейнера (флаг `--apply-migrations`).

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
- **Docker Compose** стек: `app` (Serverpod) + `db` (PostgreSQL) + `nginx` + `certbot`
- **Nginx** проксирует HTTPS → `http://app:8080` (имя Docker-сервиса)
  - `map $http_upgrade $connection_upgrade` — корректная обработка WebSocket
- **БД:** `family_chat_db` / `family_chat_user` (данные в volume `postgres_data`)
- **Директория на VPS:** `~/family_chat/`
- **Образ сервера:** `ghcr.io/alex-pf/family_chat:latest`

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

Эти переменные передаются через `.env` файл Docker Compose (записывается в `first_deploy.yml` из inputs).

### Расширяемость

Архитектура рассчитана на рост:
- Flutter Web сейчас → нативные iOS/Android/Desktop в будущем
- Встроенные игры и дополнительные функции
- Миграции БД — через встроенный механизм Serverpod

---

## Структура сервера на VPS

```
~/family_chat/
├── docker-compose.yml       # Описание стека контейнеров
├── .env                     # Секреты для docker compose (chmod 600, не в git)
├── config/
│   ├── production.yaml      # Конфиг сервера (порты, БД, домен)
│   └── passwords.yaml       # Секреты Serverpod (chmod 600)
└── nginx/
    ├── nginx.conf           # Активная конфигурация nginx (SSL после first deploy)
    └── nginx.ssl.conf       # Шаблон SSL-конфига (резерв)
```

Данные PostgreSQL хранятся в Docker volume `postgres_data` (персистентны между перезапусками).

---

## Полезные команды

```bash
cd ~/family_chat

# Статус контейнеров
docker compose ps

# Логи сервера в реальном времени
docker compose logs app -f

# Последние 50 строк логов
docker compose logs app --tail=50

# Перезапуск сервера
docker compose restart app

# Перезапуск всего стека
docker compose down && docker compose up -d

# Обновить образ вручную (обычно делает CI)
docker compose pull && docker compose up -d

# Посмотреть таблицы БД
docker compose exec db psql -U family_chat_user -d family_chat_db -c "\dt"

# Зайти в БД интерактивно
docker compose exec db psql -U family_chat_user -d family_chat_db
```

---

## Диагностика

### Сервер не запускается

```bash
cd ~/family_chat
docker compose logs app --tail=50
```

Частые причины:
- Неверный пароль БД → проверьте `~/family_chat/config/passwords.yaml`
- БД ещё не готова → `docker compose logs db` — проверьте healthcheck
- Образ не скачался → `docker compose pull`

### nginx возвращает «No method name specified»

Проверьте `~/family_chat/nginx/nginx.conf` — должны быть `map $http_upgrade $connection_upgrade` и `proxy_set_header Connection $connection_upgrade`.

### Ошибка подключения в браузере (ERR_TIMED_OUT)

`proxy_pass` в nginx.conf должен указывать на `http://app:8080` (имя Docker-сервиса), не на `localhost`.

### Таблицы не создались после миграции

Контейнер `app` запускается с `--apply-migrations`. Проверьте логи: `docker compose logs app --tail=100`.

### Нет прав на запуск docker

Убедитесь что `devuser` в группе docker: `groups devuser`. Если нет — `sudo usermod -aG docker devuser` и переподключиться.

---

## Ссылки

- **Приложение:** https://alex-pf.github.io/family_chat/
- **Serverpod docs:** https://docs.serverpod.dev
- **Flutter docs:** https://docs.flutter.dev
