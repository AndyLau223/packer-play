#!/usr/bin/env bash

terraform init
echo 

terraform fmt
echo 

terraform plan
echo 

terraform apply -auto-approve

terraform show

terraform output

terraform destroy -auto-approve

