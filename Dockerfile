FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

CMD echo "=== Checking routes in code ===" && \
    grep -n "do_GET\|do_POST\|path\|/mcp" server.py && \
    sed -i 's/localhost/0.0.0.0/g' server.py && \
    sed -i 's/127\.0\.0\.1/0.0.0.0/g' server.py && \
    python3 -u server.py

