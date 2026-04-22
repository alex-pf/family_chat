# Stage 1: build
FROM dart:stable AS builder
WORKDIR /app
COPY family_chat_sp_server/ .
RUN dart pub get && \
    dart compile exe bin/main.dart -o family_chat_server_bin

# Stage 2: runtime
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates libssl3 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app/family_chat_server_bin .
RUN chmod +x family_chat_server_bin
COPY family_chat_sp_server/migrations/ ./migrations/
CMD ["./family_chat_server_bin", "--mode", "production", "--apply-migrations"]
