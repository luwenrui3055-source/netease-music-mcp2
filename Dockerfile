FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

CMD sed -i 's/localhost/0.0.0.0/g' server.py && \
    sed -i 's/127\.0\.0\.1/0.0.0.0/g' server.py && \
    echo "=== Testing Cookie ===" && \
    python3 -c "
import os
import json
import urllib.request
cookie = os.environ.get('NETEASE_COOKIE', '')
print(f'Cookie length: {len(cookie)}')
print(f'Has MUSIC_U: {\"MUSIC_U\" in cookie}')
print(f'Has __csrf: {\"__csrf\" in cookie}')

# 测试获取用户信息
url = 'https://music.163.com/api/nuser/account/get'
req = urllib.request.Request(url, headers={'Cookie': cookie})
try:
    resp = urllib.request.urlopen(req)
    data = json.loads(resp.read())
    print(f'User ID test result: {data}')
except Exception as e:
    print(f'Error: {e}')
" && \
    echo "=== Starting server ===" && \
    python3 -u server.py

