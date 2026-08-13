FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

CMD python3 -u server.py || (echo "Server failed to start" && sleep 10)
