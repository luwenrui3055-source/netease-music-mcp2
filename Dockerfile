FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

# 逐步调试
CMD echo "Step 1: Python version" && \
    python3 --version && \
    echo "Step 2: Check files" && \
    ls -la && \
    echo "Step 3: Check server.py exists" && \
    test -f server.py && echo "server.py exists" || echo "server.py missing" && \
    echo "Step 4: Try basic Python" && \
    python3 -c "print('Python works')" && \
    echo "Step 5: Start server" && \
    python3 server.py
