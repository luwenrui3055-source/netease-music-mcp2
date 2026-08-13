FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

CMD echo "Starting NetEase Music MCP..." && \
    python3 -u server.py
