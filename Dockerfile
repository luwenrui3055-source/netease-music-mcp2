FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

# 启动并保持运行
CMD echo "Starting server..." && \
    python3 server.py & \
    SERVER_PID=$! && \
    sleep 5 && \
    echo "Checking if server is still running..." && \
    ps aux | grep python && \
    netstat -tlnp 2>/dev/null | grep 8080 || echo "No netstat" && \
    echo "Server PID: $SERVER_PID" && \
    wait $SERVER_PID
