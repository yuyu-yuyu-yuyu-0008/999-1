import asyncio
from playwright.async_api import async_playwright

async def fetch_yahoo():
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True, args=["--no-sandbox"])
        page = await browser.new_page()
        await page.goto("https://tw.yahoo.com/", timeout=60000)
        content = await page.content()
        await browser.close()
        return content

# ¥Dµ{¦¡
if __name__ == "__main__":
    html = asyncio.run(fetch_yahoo())
    print(html)

