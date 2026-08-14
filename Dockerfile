FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

CMD sed -i 's/localhost/0.0.0.0/g' server.py && \
    sed -i 's/127\.0\.0\.1/0.0.0.0/g' server.py && \
    echo "=== Cookie Info ===" && \
    echo "Cookie length: ${#NETEASE_COOKIE}" && \
    echo "Cookie preview: ${NETEASE_COOKIE:0:50}..." && \
    echo "=== Starting server ===" && \
    python3 -u server.py
