import requests

services = {
    "auth-service": "http://localhost:8000/health",
    "catalog-service": "http://localhost:8001/health",
    "cart-service": "http://localhost:8002/health",
    "order-service": "http://localhost:8003/health",
    "payment-service": "http://localhost:8004/health",
    "inventory-service": "http://localhost:8005/health"
}

for name, url in services.items():
    try:
        resp = requests.get(url, timeout=5).json()
        print(f"{name} -> OK: {resp}")
    except Exception as e:
        print(f"{name} -> ERROR: {e}")

