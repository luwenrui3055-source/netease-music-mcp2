FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

# 简化调试版本
CMD echo "=== 环境变量检查 ===" && \
    env | grep -E "(MCP|NETEASE|PORT)" && \
    echo "=== Python 版本 ===" && \
    python3 --version && \
    echo "=== 文件检查 ===" && \
    ls -la server.py && \
    echo "=== 尝试启动 ===" && \
    python3 -c "import sys; print('Python working')" && \
    echo "=== 启动服务 ===" && \
    python3 server.py

