#!/bin/bash

set -e

# Configurable variables
RESOURCE_GROUP="employeeResourceGroup"
CLUSTER_NAME="employeeAKSCluster"
LOCATION="australiaeast"

echo "🔐 Logging into Azure..."
az login --use-device-code

echo "📁 Creating resource group: $RESOURCE_GROUP"
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

echo "🔧 Creating AKS cluster: $CLUSTER_NAME"
az aks create   --resource-group "$RESOURCE_GROUP"   --name "$CLUSTER_NAME"   --node-count 1   --no-ssh-key

echo "🔗 Getting AKS credentials"
az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME"

echo "✅ AKS setup complete. You can now deploy the app using ./deploy.sh"
