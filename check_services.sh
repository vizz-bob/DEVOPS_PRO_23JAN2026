#!/bin/bash

# List of services and ports
SERVICES=("auth-service:8000" "catalog-service:8000" "order-service:8000" "payment-service:8000" "inventory-service:8000" "cart-service:8000")

# Loop through each container
for SRC in "${SERVICES[@]}"; do
    SRC_NAME=${SRC%%:*}
    echo "Checking connectivity from $SRC_NAME..."
    
    for DST in "${SERVICES[@]}"; do
        DST_NAME=${DST%%:*}
        DST_PORT=${DST##*:}
        if [ "$SRC_NAME" != "$DST_NAME" ]; then
            docker exec -it $SRC_NAME python -c "import socket; sock=socket.socket(); sock.settimeout(3); \
try: sock.connect(('$DST_NAME',$DST_PORT)); print('✅ $SRC_NAME can reach $DST_NAME:$DST_PORT') \
except Exception as e: print('❌ $SRC_NAME cannot reach $DST_NAME:$DST_PORT ->', e); sock.close()"
        fi
    done
    echo "-----------------------------"
done

