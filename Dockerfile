FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

CMD sed -i 's/localhost/0.0.0.0/g' server.py && \
    sed -i 's/127\.0\.0\.1/0.0.0.0/g' server.py && \
    sed -i 's/PORT = .*/PORT = 8080/g' server.py && \
    echo "=== Forcing port 8080 ===" && \
    grep -n "PORT" server.py && \
    echo "=== Starting server ===" && \
    python3 -u server.py

