#!/bin/bash

# List of service container names
services=("auth-service" "catalog-service" "order-service" "payment-service" "inventory-service" "cart-service")
port=8000

# Print header row
printf "%-20s" "From \\ To"
for s in "${services[@]}"; do
    printf "%-20s" "$s"
done
echo
echo "--------------------------------------------------------------------------------"

# Check connectivity
for SRC in "${services[@]}"; do
    printf "%-20s" "$SRC"
    for DST in "${services[@]}"; do
        if [ "$SRC" == "$DST" ]; then
            printf "%-20s" "-"
        else
            result=$(docker exec "$SRC" python - <<EOF
import socket
sock = socket.socket()
sock.settimeout(2)
try:
    sock.connect(('$DST', $port))
    print('✅')
except:
    print('❌')
finally:
    sock.close()
EOF
)
            printf "%-20s" "$result"
        fi
    done
    echo
done

