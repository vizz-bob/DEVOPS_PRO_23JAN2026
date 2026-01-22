#!/bin/bash

# Spinner function
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while kill -0 $pid 2>/dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "      \b\b\b\b\b\b"
}

echo "⏳ Checking EKS cluster status every 10 seconds..."

while true; do
    STATUS=$(aws eks describe-cluster --name ecommerce-cluster --region ap-south-1 --query "cluster.status" --output text)
    echo "Cluster status: $STATUS"
    if [ "$STATUS" = "ACTIVE" ]; then
        echo "✅ Cluster is ACTIVE!"
        break
    fi
    sleep 10 &
    spinner $!  # show spinner during sleep
done

