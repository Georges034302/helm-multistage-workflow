#!/bin/bash

set -e

# 🔧 Usage: ./deploy.sh [dev|staging|prod]
ENVIRONMENT=${1:-dev}  # default to 'dev' if no argument provided

RELEASE_NAME="employee-app-$ENVIRONMENT"
CHART_DIR="./employee-app"
NAMESPACE="$ENVIRONMENT"
VALUES_FILE="$CHART_DIR/values-$ENVIRONMENT.yaml"

echo "📦 Deploying to environment: $ENVIRONMENT"
echo "🛠  Release name: $RELEASE_NAME"
echo "📁 Namespace: $NAMESPACE"
echo "📄 Using values file: $VALUES_FILE"

# ✅ Ensure namespace exists (idempotent)
kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

# 🚀 Deploy with Helm
helm upgrade --install "$RELEASE_NAME" "$CHART_DIR" \
  --namespace "$NAMESPACE" \
  --values "$VALUES_FILE"

# 🌐 Wait for service IP
echo "🌐 Waiting for external IP..."
kubectl get svc -n "$NAMESPACE" --watch
