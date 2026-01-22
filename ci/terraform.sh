#!/bin/bash
cd infra/terraform || exit
terraform init
terraform apply -auto-approve

