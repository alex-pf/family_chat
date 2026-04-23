# Stage 1: build
FROM dart:stable AS builder
WORKDIR /workspace
# Copy the full Dart workspace (server needs client package via workspace resolution)
COPY pubspec.yaml ./
COPY family_chat_sp_client/ ./family_chat_sp_client/
COPY family_chat_sp_server/ ./family_chat_sp_server/
# Flutter package is in the workspace but not needed for server build;
# create a minimal stub so workspace resolution succeeds
COPY family_chat_sp_flutter/pubspec.yaml ./family_chat_sp_flutter/
RUN dart pub get
WORKDIR /workspace/family_chat_sp_server
RUN dart compile exe bin/main.dart -o family_chat_server_bin

# Stage 2: runtime
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates libssl3 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /workspace/family_chat_sp_server/family_chat_server_bin .
RUN chmod +x family_chat_server_bin
COPY family_chat_sp_server/migrations/ ./migrations/
CMD ["./family_chat_server_bin", "--mode", "production", "--apply-migrations"]
