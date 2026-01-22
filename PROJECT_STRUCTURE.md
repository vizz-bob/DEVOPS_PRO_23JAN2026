# E-commerce Platform Project Structure

## Services
- auth
  - app/
  - Dockerfile
  - helm/
  - README.md
  - requirements.txt
  - tests/
- cart
  - app/
  - Dockerfile
  - helm/
  - README.md
  - requirements.txt
  - tests/
- catalog
  - app/
  - Dockerfile
  - helm/
  - README.md
  - requirements.txt
  - tests/
- inventory
  - app/
  - Dockerfile
  - helm/
  - README.md
  - requirements.txt
  - tests/
- order
  - app/
  - Dockerfile
  - helm/
  - README.md
  - requirements.txt
  - tests/
- payment
  - app/
  - Dockerfile
  - helm/
  - README.md
  - requirements.txt
  - tests/

## Infrastructure
- infra/
  - terraform/

## CI/CD
- ci/

## Documentation
- docs/
  - architecture.md
  - db_schema.md
  - api.md
  - payment_flow.md
  - security.md
  - cicd.md
  - observability.md
  - runbook.md

## Scripts & Helpers
- check_services_health.py
- check_services_matrix.py
- check_services_matrix.sh
- check_services_table.sh
- check_services.sh
- localstack/init/create-resources.sh
- Makefile
- ops/k8s/
- scripts/

## Docker / Compose
- docker-compose.yml

## Virtual Environment
- venv/
  - bin/
  - include/
  - lib/
  - pyvenv.cfg

