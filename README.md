# FamilyChat

Приватный семейный мессенджер с реал-тайм чатами, построенный на [Serverpod](https://serverpod.dev/) 3.4.6 и Flutter.

---

## Содержание

1. [Что такое FamilyChat](#что-такое-familychat)
2. [Архитектура](#архитектура)
3. [Локальная разработка](#локальная-разработка)
4. [Первоначальная настройка VPS](#первоначальная-настройка-vps)
5. [GitHub Secrets](#github-secrets)
6. [CI/CD — как работает деплой](#cicd--как-работает-деплой)
7. [Первый запуск и создание Admin](#первый-запуск-и-создание-admin)

---

## Что такое FamilyChat

FamilyChat — закрытый мессенджер для семьи. Позволяет создавать групповые и личные чаты, обмениваться сообщениями в реальном времени. Доступ по приглашению — только Admin может регистрировать новых пользователей.

**Ключевые особенности:**
- Реал-тайм WebSocket-чат (Serverpod streaming)
- Flutter Web + мобильные платформы из одной кодовой базы
- Аутентификация через JWT (Serverpod auth)
- Самостоятельный хостинг на своём VPS

---

## Архитектура

```
┌─────────────────────────────────────────┐
│            Flutter Client               │
│  (Web / Android / iOS)                  │
│  family_chat_flutter/                   │
└──────────────┬──────────────────────────┘
               │ HTTPS / WSS (port 443)
               │ via Nginx reverse proxy
┌──────────────▼──────────────────────────┐
│          Serverpod Server               │
│  family_chat_server/  (port 8080)       │
│                                         │
│  Endpoints → ORM → PostgreSQL           │
│  Message Bus → WebSocket streams        │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│           PostgreSQL                    │
│  family_chat_db                         │
└─────────────────────────────────────────┘
```

**Стек:**
| Компонент | Технология | Версия |
|-----------|-----------|--------|
| Backend   | Serverpod | 3.4.6  |
| Language  | Dart      | ^3.8.0 |
| Frontend  | Flutter   | ^3.32.0|
| Database  | PostgreSQL| 14+    |
| Web-сервер| Nginx     | —      |
| CI/CD     | GitHub Actions | — |

**Структура репозитория:**
```
family_chat/
├── family_chat_server/    # Dart/Serverpod backend
│   ├── bin/main.dart      # Точка входа
│   ├── lib/server.dart    # Инициализация
│   ├── lib/src/           # Endpoints, models
│   ├── config/            # production.yaml (passwords.yaml — вне git)
│   └── migrations/        # SQL-миграции
├── family_chat_client/    # Dart client (генерируется Serverpod)
├── family_chat_flutter/   # Flutter приложение
├── deploy/
│   ├── setup_vps.sh       # Первоначальная настройка VPS
│   └── update_admin_env.sh# Очистка Admin env после первого запуска
├── .github/workflows/
│   └── deploy.yml         # CI/CD: Flutter Web + VPS деплой
├── .gitignore
└── README.md
```

---

## Локальная разработка

### Требования
- [Dart SDK](https://dart.dev/get-dart) ^3.8.0
- [Flutter SDK](https://flutter.dev/docs/get-started/install) ^3.32.0
- [Serverpod CLI](https://docs.serverpod.dev/get-started): `dart pub global activate serverpod_cli`
- PostgreSQL (локальный или Docker)
- Docker (опционально, для `serverpod run`)

### Запуск

```bash
# 1. Клонировать репозиторий
git clone https://github.com/alex-pf/family_chat.git
cd family_chat

# 2. Запустить сервер (dev-режим с hot reload)
cd family_chat_server
dart pub get
dart run bin/main.dart --mode development

# 3. В другом терминале — Flutter приложение
cd ../family_chat_flutter
flutter pub get
flutter run -d chrome  # или другое устройство

# 4. Регенерировать код после изменения .spy.yaml моделей
cd ../family_chat_server
serverpod generate
```

### Конфиг для dev

Создайте `family_chat_server/config/development.yaml` (не в git):
```yaml
apiServer:
  port: 8080
  publicHost: localhost
  publicPort: 8080
  publicScheme: http

database:
  host: localhost
  port: 5432
  name: family_chat_db
  user: family_chat_user
  requireSsl: false

redis:
  enabled: false
```

---

## Первоначальная настройка VPS

Скрипт `deploy/setup_vps.sh` выполняет всё необходимое за один запуск.

### Что делает скрипт:
1. Устанавливает Nginx, PostgreSQL, Certbot, Dart SDK
2. Создаёт пользователя `deploy` с нужными правами
3. Создаёт директорию `/opt/family_chat/` с правильными разрешениями
4. Настраивает PostgreSQL: создаёт БД и пользователя
5. Генерирует `/opt/family_chat/config/production.yaml`
6. Создаёт и активирует systemd-сервис `family-chat`
7. Настраивает Nginx с поддержкой WebSocket и reverse proxy

### Запуск (от root):

```bash
# Подключиться к VPS
ssh root@YOUR_VPS_IP

# Скачать и запустить скрипт
curl -O https://raw.githubusercontent.com/alex-pf/family_chat/main/deploy/setup_vps.sh
bash setup_vps.sh chat.example.com
```

### После запуска скрипта:

1. **Добавить SSH-ключ** (публичный от `VPS_SERVER_KEY`) в `/home/deploy/.ssh/authorized_keys`
2. **Получить SSL-сертификат:**
   ```bash
   certbot --nginx -d chat.example.com
   ```
3. **Добавить GitHub Secrets** (см. раздел ниже)
4. **Сделать push в main** — CI/CD задеплоит сервер

---

## GitHub Secrets

Перейдите в `Settings → Secrets and variables → Actions` вашего репозитория и добавьте:

### Уже настроены (инфраструктурные):

| Secret | Описание |
|--------|----------|
| `VPS_IP` | IP-адрес VPS сервера |
| `VPS_SERVER_KEY` | Приватный SSH-ключ для пользователя `deploy` на VPS |
| `ADMIN_EMAIL` | Email первого администратора |
| `ADMIN_INITIAL_PASSWORD` | Начальный пароль администратора |

### Необходимо добавить (production secrets для Serverpod):

| Secret | Описание | Как сгенерировать |
|--------|----------|-------------------|
| `DB_PASSWORD` | Пароль PostgreSQL для `family_chat_user` | Выводится скриптом `setup_vps.sh` |
| `SERVICE_SECRET` | Секрет Serverpod для межсервисной связи | `openssl rand -hex 32` |
| `EMAIL_PEPPER` | Pepper для хеширования email | `openssl rand -hex 32` |
| `JWT_PRIVATE_KEY` | HMAC-SHA512 ключ для JWT токенов | `openssl rand -hex 64` |
| `JWT_REFRESH_PEPPER` | Pepper для refresh токенов | `openssl rand -hex 32` |

> **Важно:** Никогда не добавляйте `passwords.yaml` или любые ключи в git. Файл `/opt/family_chat/config/passwords.yaml` создаётся автоматически CI/CD при каждом деплое через SSH и не попадает в репозиторий.

---

## CI/CD — как работает деплой

Workflow `.github/workflows/deploy.yml` запускается при каждом `push` в ветку `main` и выполняет **два независимых job**:

### Job 1: `deploy-flutter-web`

```
push to main
    ↓
Checkout code
    ↓
Setup Flutter (stable channel, с кешем)
    ↓
flutter pub get + flutter build web --base-href /family_chat/ --wasm
    ↓
Upload artifact → Deploy to GitHub Pages
    ↓
Flutter Web доступен по адресу GitHub Pages
```

### Job 2: `deploy-server`

```
push to main
    ↓
Checkout code
    ↓
Setup Dart SDK (stable)
    ↓
dart pub get + dart compile exe bin/main.dart → family_chat_server_bin
    ↓
SSH: Создать/обновить /opt/family_chat/config/passwords.yaml из GitHub Secrets
    ↓
SCP: Скопировать бинарник + конфиги + миграции на VPS → /opt/family_chat/
    ↓
SSH: chmod +x бинарник → sudo systemctl restart family-chat
    ↓
SSH: sudo systemctl status family-chat (проверка)
```

**Почему компиляция в CI, а не на VPS?**
- Быстрее: GitHub Actions имеет мощные runner-машины
- Проще VPS: не нужен Dart SDK на сервере
- Надёжнее: чистая среда без локальных зависимостей

**Флаг `--apply-migrations`** в systemd ExecStart автоматически применяет новые SQL-миграции при каждом запуске. Serverpod отслеживает какие миграции уже применены — повторного применения не будет.

---

## Первый запуск и создание Admin

Перед первым деплоем необходимо передать credentials Admin в systemd-сервис:

### Шаг 1: Задать credentials Admin на VPS

```bash
# SSH на VPS от root
ssh root@YOUR_VPS_IP

# Открыть файл сервиса
nano /etc/systemd/system/family-chat.service

# Найти строки и заполнить:
Environment="ADMIN_EMAIL=admin@example.com"
Environment="ADMIN_INITIAL_PASSWORD=SecurePassword123!"

# Применить изменения
systemctl daemon-reload
```

### Шаг 2: Первый деплой

```bash
git push origin main
```

GitHub Actions:
1. Скомпилирует сервер
2. Запишет `passwords.yaml` на VPS
3. Скопирует бинарник и миграции
4. Перезапустит `family-chat` сервис

При первом запуске сервер прочтёт `ADMIN_EMAIL` и `ADMIN_INITIAL_PASSWORD` из env и создаст учётную запись администратора.

### Шаг 3: Очистить credentials после первого входа

После того как вы убедились, что Admin-аккаунт работает:

```bash
# На VPS
sudo bash /opt/family_chat/update_admin_env.sh
sudo systemctl restart family-chat
```

Это обнулит переменные в systemd — повторного создания Admin не произойдёт.

---

## Полезные команды для обслуживания

```bash
# Статус сервиса
sudo systemctl status family-chat

# Логи в реальном времени
journalctl -u family-chat -f

# Перезапуск
sudo systemctl restart family-chat

# Проверить nginx конфиг
nginx -t

# Обновить SSL сертификат
certbot renew --dry-run
```
