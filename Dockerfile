FROM python:3.9-slim

WORKDIR /app
COPY . .
WORKDIR /app/server/mcp-server

EXPOSE 8080

# 直接显示错误
CMD python3 -u server.py 2>&1 || echo "Python 应用启动失败"

# 调试：检查文件结构
RUN echo "=== 检查文件 ===" && ls -la

# 调试：检查 Python 文件内容
RUN echo "=== 检查 server.py 前几行 ===" && head -10 server.py || echo "server.py 不存在"

# 调试：检查环境变量
RUN echo "=== 环境变量检查 ===" && env | grep -E "(MCP|NETEASE)" || echo "未找到相关环境变量"

EXPOSE 8080

# 调试启动：先测试 Python，再尝试启动应用
CMD echo "=== 开始启动 ===" && \
    echo "当前目录：$(pwd)" && \
    echo "Python 版本：$(python3 --version)" && \
    echo "文件列表：$(ls -la)" && \
    echo "尝试启动应用..." && \
    python3 server.py
