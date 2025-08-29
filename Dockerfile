# 使用 Playwright 官方基底映像
FROM mcr.microsoft.com/playwright:v1.30.0-focal

# 設定工作目錄
WORKDIR /app

# 安裝 Python & pip
RUN apt-get update && apt-get install -y python3 python3-pip

# 安裝 Python 依賴
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# 複製應用程式碼
COPY . .

# 確認 Chromium 已安裝（方便 debug）
RUN python3 -c "from playwright.sync_api import sync_playwright; p = sync_playwright().start(); print(p.chromium.executable_path); p.stop()"

# 暴露 Hugging Face Space 預設 port
EXPOSE 7860

# 啟動 FastAPI 應用
CMD ["python3", "999.py"]
