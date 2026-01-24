#!/bin/bash
services=("auth-service" "catalog-service" "order-service" "payment-service" "inventory-service" "cart-service")
port=8000

GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

# Print header
printf "From \\ To\t\t"
for s in "${services[@]}"; do
    printf "%-18s" "$s"
done
echo
printf '%0.s-' {1..120}
echo

for src in "${services[@]}"; do
    printf "%-15s" "$src"
    for dst in "${services[@]}"; do
        if [ "$src" == "$dst" ]; then
            printf "%-18s" "-"
        else
            result=$(docker exec "$src" python3 -c "
import socket
s=socket.socket()
s.settimeout(2)
try:
    s.connect(('${dst}', ${port}))
    print('✅', end='')
except:
    print('❌', end='')
s.close()
")
            if [ "$result" == "✅" ]; then
                printf "${GREEN}%-18s${RESET}" "$result"
            else
                printf "${RED}%-18s${RESET}" "$result"
            fi
        fi
    done
    echo
done

