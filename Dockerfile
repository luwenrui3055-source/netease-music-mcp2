FROM python:3.9-slim

WORKDIR /app

# 复制整个项目
COPY . .

# 设置工作目录到 server/mcp-server
WORKDIR /app/server/mcp-server

# 暴露端口
EXPOSE 8080

# 启动命令
CMD ["python3", "server.py"]
