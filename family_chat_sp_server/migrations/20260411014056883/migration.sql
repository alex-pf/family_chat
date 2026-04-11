BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_notifications" (
    "id" bigserial PRIMARY KEY,
    "recipientUserId" bigint NOT NULL,
    "type" text NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "relatedEntityId" bigint,
    "isRead" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "notif_recipient_idx" ON "app_notifications" USING btree ("recipientUserId", "isRead");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_users" (
    "id" bigserial PRIMARY KEY,
    "serverpodUserId" text,
    "email" text NOT NULL,
    "name" text NOT NULL,
    "avatarColor" text NOT NULL,
    "avatarInitials" text NOT NULL,
    "isBlocked" boolean NOT NULL DEFAULT false,
    "mustChangePassword" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL,
    "lastSeenAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "app_user_email_idx" ON "app_users" USING btree ("email");
CREATE UNIQUE INDEX "app_user_spid_idx" ON "app_users" USING btree ("serverpodUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_members" (
    "id" bigserial PRIMARY KEY,
    "chatId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL,
    "lastReadMessageId" bigint
);

-- Indexes
CREATE UNIQUE INDEX "chat_member_unique" ON "chat_members" USING btree ("chatId", "userId");
CREATE INDEX "chat_member_chat_idx" ON "chat_members" USING btree ("chatId");
CREATE INDEX "chat_member_user_idx" ON "chat_members" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_messages" (
    "id" bigserial PRIMARY KEY,
    "chatId" bigint NOT NULL,
    "senderUserId" bigint NOT NULL,
    "text" text,
    "imageUrl" text,
    "fileUrl" text,
    "fileName" text,
    "fileSize" bigint,
    "isDeleted" boolean NOT NULL DEFAULT false,
    "isEdited" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL,
    "editedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "message_chat_idx" ON "chat_messages" USING btree ("chatId");
CREATE INDEX "message_sender_idx" ON "chat_messages" USING btree ("senderUserId");
CREATE INDEX "message_created_idx" ON "chat_messages" USING btree ("chatId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chats" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "isGroup" boolean NOT NULL DEFAULT false,
    "ownerUserId" bigint,
    "backgroundId" text NOT NULL DEFAULT 'default'::text,
    "textColor" text NOT NULL DEFAULT '#FFFFFF'::text,
    "isArchived" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "message_reactions" (
    "id" bigserial PRIMARY KEY,
    "messageId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "emoji" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "reaction_unique" ON "message_reactions" USING btree ("messageId", "userId", "emoji");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "message_statuses" (
    "id" bigserial PRIMARY KEY,
    "messageId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "status" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "msg_status_unique" ON "message_statuses" USING btree ("messageId", "userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "one_time_tokens" (
    "id" bigserial PRIMARY KEY,
    "token" text NOT NULL,
    "userId" bigint NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "usedAt" timestamp without time zone,
    "requestedByUserId" bigint
);

-- Indexes
CREATE UNIQUE INDEX "ott_token_idx" ON "one_time_tokens" USING btree ("token");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "system_settings" (
    "id" bigserial PRIMARY KEY,
    "key" text NOT NULL,
    "value" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "settings_key_idx" ON "system_settings" USING btree ("key");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_role_assignments" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "assignedAt" timestamp without time zone NOT NULL,
    "assignedByUserId" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_role_unique" ON "user_role_assignments" USING btree ("userId", "role");


--
-- MIGRATION VERSION FOR family_chat_sp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('family_chat_sp', '20260411014056883', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260411014056883', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
