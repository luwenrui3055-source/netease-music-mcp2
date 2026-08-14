FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

# 检查并修改监听地址
RUN echo "=== Original server.py content (first 30 lines) ===" && \
    head -30 server.py && \
    echo "=== Patching server.py ===" && \
    sed -i 's/localhost/0.0.0.0/g' server.py && \
    sed -i 's/127\.0\.0\.1/0.0.0.0/g' server.py && \
    sed -i "s/'127\.0\.0\.1'/'0.0.0.0'/g" server.py && \
    sed -i 's/"127\.0\.0\.1"/"0.0.0.0"/g' server.py && \
    echo "=== After patching ===" && \
    grep -A5 -B5 "0.0.0.0" server.py || echo "No 0.0.0.0 found"

EXPOSE 8080

CMD python3 -u server.py

