from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Payment(BaseModel):
    order_id: int
    method: str

payments = {}
payment_counter = 1

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/payment/process")
def process_payment(payment: Payment):
    global payment_counter
    payments[payment_counter] = {"payment_id": payment_counter, "order_id": payment.order_id, "method": payment.method}
    payment_counter += 1
    return {"status": "processed", "payment_id": payment_counter - 1}

@app.get("/payment/{payment_id}")
def get_payment(payment_id: int):
    return payments.get(payment_id, {"status": "not_found"})

