from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class CartItem(BaseModel):
    item_id: int
    quantity: int

cart_db = []

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/cart/items")
def add_item(item: CartItem):
    cart_db.append(item.dict())
    return {"status": "added", "item": item}

@app.get("/cart/items")
def list_items():
    return cart_db

@app.delete("/cart/items/{item_id}")
def remove_item(item_id: int):
    global cart_db
    cart_db = [i for i in cart_db if i["item_id"] != item_id]
    return {"status": "removed", "item_id": item_id}

