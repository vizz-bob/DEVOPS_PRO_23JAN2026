# check_services.py
import requests

services = {
    "auth-service": 8000,
    "catalog-service": 8001,
    "cart-service": 8002,
    "order-service": 8003,
    "payment-service": 8004,
    "inventory-service": 8005,
}

for name, port in services.items():
    url = f"http://localhost:{port}/health"
    try:
        r = requests.get(url)
        print(f"{name} -> {r.json()}")
    except Exception as e:
        print(f"{name} -> ERROR: {e}")

