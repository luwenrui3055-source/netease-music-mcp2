FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

# 创建一个补丁文件来更新请求头
RUN cat > headers_patch.py << 'EOF'
import re

# 读取原文件
with open('server.py', 'r', encoding='utf-8') as f:
    content = f.read()

# 添加完整的请求头
headers_code = '''
        headers = {
            'Cookie': cookie,
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'Accept': 'application/json, text/plain, */*',
            'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
            'Accept-Encoding': 'gzip, deflate, br',
            'Referer': 'https://music.163.com/',
            'Origin': 'https://music.163.com',
            'Connection': 'keep-alive',
            'Sec-Fetch-Dest': 'empty',
            'Sec-Fetch-Mode': 'cors',
            'Sec-Fetch-Site': 'same-origin',
            'sec-ch-ua': '"Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"',
            'sec-ch-ua-mobile': '?0',
            'sec-ch-ua-platform': '"Windows"'
        }'''

# 替换现有的headers设置
content = re.sub(r"headers\s*=\s*{\s*['\"]Cookie['\"]:\s*cookie.*?}", headers_code, content, flags=re.DOTALL)

# 写回文件
with open('server.py', 'w', encoding='utf-8') as f:
    f.write(content)
EOF

EXPOSE 8080

CMD python3 headers_patch.py && \
    sed -i 's/localhost/0.0.0.0/g' server.py && \
    sed -i 's/127\.0\.0\.1/0.0.0.0/g' server.py && \
    echo "Headers patched and server starting" && \
    python3 -u server.py

