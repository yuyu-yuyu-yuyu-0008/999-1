# 使用正確版本的 Playwright Docker 映像作為基礎
FROM mcr.microsoft.com/playwright:v1.30.0-focal

# 設定工作目錄
WORKDIR /app

# 安裝必要的依賴，包括 Xvfb
RUN apt-get update && \
    apt-get install -y python3-pip xvfb

# 複製應用代碼
COPY . .

# 安裝 Python 依賴
RUN pip3 install -r requirements.txt

# 檢查 Chromium 是否正確安裝
RUN python3 -c "from playwright.sync_api import sync_playwright; p = sync_playwright().start(); print(p.chromium.executable_path); p.stop()"

# 暴露應用所需的端口
EXPOSE 7860



# 使用 Xvfb 启动虛擬顯示並運行應用
CMD ["sh", "-c", "rm -f /tmp/.X99-lock && Xvfb :99 -screen 0 1024x768x24 & export DISPLAY=:99 && python3 999.py"]
