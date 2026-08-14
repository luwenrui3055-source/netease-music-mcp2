FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

CMD echo "=== Original content ===" && \
    grep -n "localhost\|127.0.0.1" server.py || echo "No localhost/127.0.0.1 found" && \
    echo "=== Applying sed patches ===" && \
    sed -i 's/localhost/0.0.0.0/g' server.py && \
    sed -i 's/127\.0\.0\.1/0.0.0.0/g' server.py && \
    echo "=== After patching ===" && \
    grep -n "0.0.0.0\|localhost\|127.0.0.1" server.py || echo "No matches after patching" && \
    echo "=== Starting server ===" && \
    python3 -u server.py
