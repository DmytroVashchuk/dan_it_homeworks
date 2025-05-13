from ib_insync import IB
import os

async def connect_ib():
    ib = IB()
    ib_host = os.getenv("IB_HOST", "192.168.112.128")
    ib_port = int(os.getenv("TWS_PORT", "7497"))
    ib_client_id = int(os.getenv("IB_CLIENT_ID", "1"))

    await ib.connectAsync(ib_host, ib_port, clientId=ib_client_id)
    return ib
