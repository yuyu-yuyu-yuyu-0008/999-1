import os
import asyncio
from fastapi import FastAPI
from playwright.async_api import async_playwright

app = FastAPI()

@app.get("/")
async def fetch_yahoo():
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True, args=["--no-sandbox"])
        page = await browser.new_page()
        await page.goto("https://tw.yahoo.com/", timeout=60000)
        content = await page.content()
        await browser.close()
        return {"html": content}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=int(os.getenv("PORT", 7860)))


