# API Documentation

## Auth Service
- POST /signup
- POST /login
- GET /health

## Cart Service
- GET /cart/{user_id}
- POST /cart/{user_id}/item
- DELETE /cart/{user_id}/item/{item_id}

## Catalog Service
- GET /products
- GET /products/{product_id}

## Inventory Service
- GET /inventory/{product_id}

## Order Service
- POST /order
- GET /order/{order_id}

## Payment Service
- POST /payment
- GET /payment/{payment_id}

