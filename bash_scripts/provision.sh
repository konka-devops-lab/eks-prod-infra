#!/bin/bash

echo "🌍 Choose the environment to deploy (e.g. development or production):"
read ENV

if [ -z "$ENV" ]; then
  echo "❌ Environment not provided. Exiting."
  exit 1
fi

cd infra || exit 1

# Terraform Init
echo "🔧 Initializing Terraform with backend config for $ENV..."
terraform init -backend-config=../environments/$ENV/backend.tfvars

# Format and Validate
echo "🧹 Formatting Terraform files..."
terraform fmt

echo "✅ Validating configuration..."
terraform validate

# Terraform Plan
echo "📋 Planning Terraform changes for $ENV..."
terraform plan -var-file=../environments/$ENV/main.tfvars -out=tfplan.out

# Prompt for Apply
echo "❓ Do you want to apply this plan? (yes/no)"
read CONFIRM

if [ "$CONFIRM" = "yes" ]; then
  echo "🚀 Applying Terraform changes..."
  terraform apply tfplan.out
else
  echo "❌ Apply cancelled."
  exit 0
fi
