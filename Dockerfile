FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

CMD echo "Checking syntax..." && \
    python3 -m py_compile server.py && \
    echo "Syntax OK, trying to run..." && \
    timeout 30 python3 -u server.py || echo "Script failed or timeout"
