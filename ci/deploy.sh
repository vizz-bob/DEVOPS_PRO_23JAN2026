#!/bin/bash
services=("auth" "cart" "catalog" "inventory" "order" "payment")

for service in "${services[@]}"; do
    echo "Deploying $service to EKS..."
    helm upgrade --install $service ./services/$service/helm
done

