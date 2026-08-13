FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

# 强制显示所有输出
CMD echo "Starting server..." && \
    python3 -u server.py 2>&1
