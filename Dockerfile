FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

# 最强调试：逐行执行并显示所有信息
CMD echo "=== Python 脚本内容检查 ===" && \
    echo "前20行内容：" && head -20 server.py && \
    echo "" && \
    echo "=== 环境变量检查 ===" && \
    env | grep -E "(MCP|NETEASE|PORT)" && \
    echo "" && \
    echo "=== 尝试导入测试 ===" && \
    python3 -c "
import sys
print('Python 路径:', sys.path)
print('尝试基本导入...')
try:
    import http.server
    import json
    import os
    import urllib.parse
    import urllib.request
    print('基本模块导入成功')
except Exception as e:
    print('导入失败:', e)
" && \
    echo "" && \
    echo "=== 启动应用 ===" && \
    python3 -v server.py
