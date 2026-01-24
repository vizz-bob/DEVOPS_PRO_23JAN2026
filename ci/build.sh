#!/bin/bash
services=("auth" "cart" "catalog" "inventory" "order" "payment")

for service in "${services[@]}"; do
    echo "Building $service..."
    docker build -t "$service-service:dev" ./services/$service
done

