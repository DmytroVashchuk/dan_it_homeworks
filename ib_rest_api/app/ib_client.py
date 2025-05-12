from ib_insync import IB
import os

def connect_ib():
    ib = IB()
    ib_host = os.getenv("IB_HOST", "127.0.0.1")
    ib_port = int(os.getenv("TWS_PORT", "7497"))
    ib_client_id = int(os.getenv("IB_CLIENT_ID", "1"))

    ib.connect(ib_host, ib_port, clientId=ib_client_id)
    return ib
