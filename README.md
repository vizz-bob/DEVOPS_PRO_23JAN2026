# Ecommerce Platform — DevOps Project

This repository implements a realistic end-to-end **cloud-native Ecommerce Platform** and associated **DevOps ecosystem**.  
It is designed as a portfolio-grade project demonstrating real-world architecture, CI/CD automation, observability, infrastructure-as-code, and developer workflows.

---

## 🚀 Key Features

✔ Microservices-based Ecommerce system  
✔ Infrastructure-as-Code (IaC) using **Terraform**  
✔ Containerized with **Docker** & **docker-compose**  
✔ Local cloud emulation via **Localstack**  
✔ Production-ready orchestration (**Kubernetes / EKS**)  
✔ GitHub Actions CI/CD pipeline  
✔ Monitoring, health-checking & service matrix reporting  
✔ Automated build/run scripts for developer efficiency  
✔ Environment parity from dev → staging → prod  

---

## 🏗 Architecture Overview

```
┌──────────────────────────────────────────────────────────┐
│                    Ecommerce Platform                    │
├──────────────────────────────────────────────────────────┤
│  Services                                                 │
│  ├── product-service (Python)                             │
│  ├── order-service (Python)                               │
│  ├── payment-service (Python)                             │
│  ├── inventory-service (Python)                           │
│  ├── auth-service                                        │
│  └── api-gateway (Nginx / FastAPI / Flask setup)          │
├──────────────────────────────────────────────────────────┤
│  Infra                                                    │
│  ├── Terraform → VPC, Subnets, EKS, ALB, IAM              │
│  ├── Kubernetes → Deployments, Services, Ingress          │
│  ├── Local development → docker-compose + Localstack      │
│  └── S3 / SNS / SQS simulation local via Localstack       │
├──────────────────────────────────────────────────────────┤
│  DevOps Tooling                                           │
│  ├── GitHub Actions CI/CD                                 │
│  ├── Health check scripts                                 │
│  ├── Makefile tasks                                       │
│  └── Service matrix reporting                             │
└──────────────────────────────────────────────────────────┘
```

---

## 🧱 Tech Stack

**Languages**
- Python / Bash / YAML

**DevOps**
- Docker / docker-compose
- Terraform
- Kubernetes (EKS)
- GitHub Actions
- Localstack
- Makefile automation

**Cloud**
- AWS (Emulated via Localstack)
  - S3, SNS, SQS, DynamoDB, IAM, EKS

---

## 🧩 Repository Structure

```
ecommerce-platform/
│
├── services/
│   ├── product-service
│   ├── order-service
│   ├── payment-service
│   ├── inventory-service
│   └── auth-service
│
├── infra/
│   ├── terraform/
│   └── k8s/
│
├── localstack/
├── docker-compose.yml
├── Makefile
├── scripts/
│   ├── check_services.sh
│   ├── check_services_matrix.sh
│   ├── check_services_table.sh
│   └── check_services_health.py
│
└── docs/
```

---

## 🧪 Local Development with Docker

```sh
make build
make up
```

Check running containers:

```sh
make ps
```

Stop stack:

```sh
make down
```

---

## ☁ Local Cloud Emulation (Localstack)

Start Localstack AWS APIs:

```sh
docker-compose -f localstack/docker-compose.yml up -d
```

Emulates:

| AWS Service | Purpose |
|---|---|
| S3 | File storage |
| SNS | Event notifications |
| SQS | Order queues |
| IAM | Service permissions |
| DynamoDB | State storage |

---

## 🧰 Developer Tooling

Health matrix:

```sh
./scripts/check_services_matrix.sh
```

Tabular status:

```sh
./scripts/check_services_table.sh
```

Detailed health:

```sh
python3 scripts/check_services_health.py
```

---

## ⚙ CI/CD — GitHub Actions

Pipeline stages:

1. **Lint & Unit Tests**
2. **Build & Tag Docker Images**
3. **Security Scans**
4. **Push to Container Registry**
5. **Deploy to Kubernetes**
6. **Post-deployment health-check**

Example pipeline snippet:

```yaml
name: CI/CD
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - run: make test
    - run: make build
```

---

## 🌩 Production Deployment (EKS)

Terraform provisions:

✔ VPC  
✔ Subnets  
✔ Internet gateway  
✔ Node groups  
✔ IAM roles  
✔ Load balancer  
✔ K8s control plane  

Deploy workloads:

```sh
kubectl apply -f infra/k8s/
```

---

## 📊 Observability

Includes:

✔ service matrix visualization  
✔ health endpoints  
✔ logs via container runtime  
✔ optional extensions:
- Prometheus
- Loki
- Grafana
- Jaeger

---

## 🚀 Future Enhancements

- Service mesh (Istio / Linkerd)
- Blue/Green or Canary deployments
- Autoscaling (HPA)
- Secret Manager / Vault
- OpenTelemetry tracing
- API Gateway + AuthN AuthZ

---

## 📁 License

MIT

---

If this project helped your learning journey, ⭐ the repo!


