from fastapi import FastAPI, HTTPException
from app.ib_client import connect_ib

app = FastAPI()

@app.get("/account")
def get_account_summary():
    try:
        ib = connect_ib()
        account_summary = ib.accountSummary()
        result = {item.tag: item.value for item in account_summary}
        ib.disconnect()
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
