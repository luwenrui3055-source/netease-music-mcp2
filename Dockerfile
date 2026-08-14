FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

# 安装curl用于测试
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD echo "=== Patching server ===" && \
    sed -i 's/localhost/0.0.0.0/g' server.py && \
    sed -i 's/127\.0\.0\.1/0.0.0.0/g' server.py && \
    grep -n "ThreadedHTTPServer" server.py && \
    echo "=== Starting server ===" && \
    python3 -u server.py & \
    sleep 5 && \
    echo "=== Testing internal connection ===" && \
    curl -v http://localhost:8080/ 2>&1 && \
    echo "=== Testing MCP endpoint ===" && \
    curl -v http://localhost:8080/mcp 2>&1 && \
    echo "=== Server should be running ===" && \
    wait
