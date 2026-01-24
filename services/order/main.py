from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Order(BaseModel):
    cart_id: int

orders = {}
order_counter = 1

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/order/create")
def create_order(order: Order):
    global order_counter
    orders[order_counter] = {"order_id": order_counter, "cart_id": order.cart_id}
    order_counter += 1
    return {"status": "created", "order_id": order_counter - 1}

@app.get("/order/{order_id}")
def get_order(order_id: int):
    return orders.get(order_id, {"status": "not_found"})

