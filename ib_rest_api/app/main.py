from fastapi import FastAPI, HTTPException
from app.ib_client import connect_ib
import asyncio

app = FastAPI()

@app.get("/account")
async def get_account_summary():
    try:
        ib = await connect_ib()  # чекаємо підключення
        account_summary = await ib.accountSummaryAsync()  # асинхронний варіант
        result = {item.tag: item.value for item in account_summary}
        await ib.disconnectAsync()
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
