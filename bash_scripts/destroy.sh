#!/bin/bash

echo "🌍 Choose the environment to destroy (e.g. development or production):"
read ENV

if [ -z "$ENV" ]; then
  echo "❌ Environment not provided. Exiting."
  exit 1
fi

cd infra || exit 1

# Terraform Init
echo "🔧 Initializing Terraform with backend config for $ENV..."
terraform init -backend-config=../environments/$ENV/backend.tfvars

# Terraform Plan
echo "📋 Planning Terraform changes for $ENV..."
terraform plan -var-file=../environments/$ENV/main.tfvars -destroy

# Prompt for Apply
echo "❓ Do you want to apply this plan? (yes/no)"
read CONFIRM

if [ "$CONFIRM" = "yes" ]; then
  echo "🚀 Destroy Infra ..."
  terraform destroy -var-file=../environments/$ENV/main.tfvars
else
  echo "❌ destroy cancelled."
  exit 0
fi
