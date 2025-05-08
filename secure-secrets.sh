#!/bin/bash

set -e

RESOURCE_GROUP="employeeResourceGroup"
KEYVAULT_NAME="employeeKeyVault"
SECRET_NAME="DB_PASSWORD"
SECRET_VALUE="supersecure123"

echo "🔐 Creating Azure Key Vault: $KEYVAULT_NAME"
az keyvault create --name "$KEYVAULT_NAME" --resource-group "$RESOURCE_GROUP" --location australiaeast

echo "🔑 Adding secret to Key Vault: $SECRET_NAME"
az keyvault secret set --vault-name "$KEYVAULT_NAME" --name "$SECRET_NAME" --value "$SECRET_VALUE"

echo "🔄 Fetching secret value and creating Kubernetes secret"
SECRET=$(az keyvault secret show --vault-name "$KEYVAULT_NAME" --name "$SECRET_NAME" --query value -o tsv)

kubectl create secret generic employee-secrets --from-literal=$SECRET_NAME="$SECRET"

echo "✅ Secret $SECRET_NAME is now available to your app as an environment variable."
