FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

# 设置监听地址环境变量
ENV HOST=0.0.0.0

EXPOSE 8080

CMD python3 -u server.py
