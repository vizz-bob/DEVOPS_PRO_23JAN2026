import requests

SERVICES = [
    "auth-service",
    "catalog-service",
    "order-service",
    "payment-service",
    "inventory-service",
    "cart-service"
]

PORT = 8000

print("Checking inter-service health...\n")

# Table header
print(f"{'From \\ To':<15}", end="")
for s in SERVICES:
    print(f"{s:<18}", end="")
print()
print("-" * (15 + 18 * len(SERVICES)))

for src in SERVICES:
    print(f"{src:<15}", end="")
    for dst in SERVICES:
        if src == dst:
            print(f"{'-':<18}", end="")
        else:
            url = f"http://{dst}:{PORT}/health"
            try:
                r = requests.get(url, timeout=2)
                if r.status_code == 200:
                    print(f"✅{'':<17}", end="")
                else:
                    print(f"❌{'':<17}", end="")
            except Exception:
                print(f"❌{'':<17}", end="")
    print()

print("\n✅ = reachable & healthy, ❌ = unreachable or unhealthy")

