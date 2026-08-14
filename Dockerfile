FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

# 安装网络工具
RUN apt-get update && apt-get install -y netstat-nat curl && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD echo "=== 启动服务器 ===" && \
    python3 -u server.py & \
    sleep 3 && \
    echo "=== 检查监听端口 ===" && \
    netstat -tlnp | grep 8080 && \
    echo "=== 测试本地连接 ===" && \
    curl -v http://localhost:8080/ 2>&1 || echo "localhost连接失败" && \
    curl -v http://127.0.0.1:8080/ 2>&1 || echo "127.0.0.1连接失败" && \
    curl -v http://0.0.0.0:8080/ 2>&1 || echo "0.0.0.0连接失败" && \
    echo "=== 保持运行 ===" && \
    wait
