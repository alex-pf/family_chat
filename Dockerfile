# Stage 1: build
FROM dart:stable AS builder
WORKDIR /workspace
# Copy the full Dart workspace (server needs client package via workspace resolution)
COPY pubspec.yaml ./
COPY family_chat_sp_client/ ./family_chat_sp_client/
COPY family_chat_sp_server/ ./family_chat_sp_server/
# Flutter package is listed in the workspace but not needed for server build.
# We create a minimal stub pubspec without Flutter SDK deps so that
# `dart pub get` (no Flutter SDK in this image) can resolve the workspace.
RUN mkdir -p family_chat_sp_flutter && \
    printf 'name: family_chat_sp_flutter\npublish_to: none\nenvironment:\n  sdk: "^3.8.0"\nresolution: workspace\n' \
    > family_chat_sp_flutter/pubspec.yaml
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
