FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

# 运行时检查并修改
CMD echo "=== Checking server.py ===" && \
    head -30 server.py && \
    echo "=== Looking for bind address ===" && \
    grep -n "bind\|listen\|host\|127\|localhost" server.py && \
    echo "=== Modifying server.py ===" && \
    sed -i 's/localhost/0.0.0.0/g' server.py && \
    sed -i 's/127\.0\.0\.1/0.0.0.0/g' server.py && \
    sed -i "s/'127\.0\.0\.1'/'0.0.0.0'/g" server.py && \
    sed -i 's/"127\.0\.0\.1"/"0.0.0.0"/g' server.py && \
    echo "=== After modification ===" && \
    grep -n "0.0.0.0\|bind\|listen\|host" server.py && \
    echo "=== Starting server ===" && \
    python3 -u server.py

