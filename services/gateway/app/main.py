# services/gateway/app/main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import httpx

app = FastAPI(title="E-Commerce Gateway")

# Allow all origins (for testing; restrict in production)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"]
)

# Microservice URLs (as defined in docker-compose)
SERVICES = {
    "auth": "http://auth-service:8000",
    "catalog": "http://catalog-service:8000",
    "cart": "http://cart-service:8000",
    "order": "http://order-service:8000",
    "payment": "http://payment-service:8000",
    "inventory": "http://inventory-service:8000"
}

# ---------------------------
# Root
# ---------------------------
@app.get("/")
async def root():
    return {"message": "Gateway is running!"}

# ---------------------------
# Cart endpoints
# ---------------------------
@app.get("/cart/items")
async def get_cart_items():
    async with httpx.AsyncClient() as client:
        resp = await client.get(f"{SERVICES['cart']}/cart/items")
        return resp.json()

@app.post("/cart/add")
async def add_cart_item(item: dict):
    if "cart_id" not in item:
        item["cart_id"] = 1  # Default cart_id for testing
    async with httpx.AsyncClient() as client:
        resp = await client.post(f"{SERVICES['cart']}/cart/add", json=item)
        return resp.json()

# ---------------------------
# Order endpoints
# ---------------------------
@app.post("/order/create")
async def create_order(order: dict):
    if "cart_id" not in order:
        order["cart_id"] = 1
    async with httpx.AsyncClient() as client:
        resp = await client.post(f"{SERVICES['order']}/order/create", json=order)
        return resp.json()

@app.get("/order/{order_id}")
async def get_order(order_id: int):
    async with httpx.AsyncClient() as client:
        resp = await client.get(f"{SERVICES['order']}/order/{order_id}")
        return resp.json()

# ---------------------------
# Payment endpoints
# ---------------------------
@app.post("/payment/process")
async def process_payment(payment: dict):
    async with httpx.AsyncClient() as client:
        resp = await client.post(f"{SERVICES['payment']}/payment/process", json=payment)
        return resp.json()

# ---------------------------
# Catalog endpoints
# ---------------------------
@app.get("/catalog/items")
async def get_catalog_items():
    async with httpx.AsyncClient() as client:
        resp = await client.get(f"{SERVICES['catalog']}/items")
        return resp.json()

# ---------------------------
# Inventory endpoints
# ---------------------------
@app.get("/inventory/items")
async def get_inventory_items():
    async with httpx.AsyncClient() as client:
        resp = await client.get(f"{SERVICES['inventory']}/inventory/items")
        return resp.json()

