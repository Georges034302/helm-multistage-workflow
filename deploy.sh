#!/bin/bash

set -e

ENVIRONMENT=${1:-dev}  # accepts "dev", "staging", or "prod"
RELEASE_NAME="employee-app-$ENVIRONMENT"
CHART_DIR="./employee-app"
NAMESPACE="$ENVIRONMENT"
VALUES_FILE="$CHART_DIR/values-$ENVIRONMENT.yaml"

echo "📦 Deploying to environment: $ENVIRONMENT"
echo "🛠 Release name: $RELEASE_NAME"
echo "📁 Namespace: $NAMESPACE"
echo "📄 Using values file: $VALUES_FILE"

kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

echo "🚀 Running Helm install/upgrade..."
helm upgrade --install "$RELEASE_NAME" "$CHART_DIR" \
  --namespace "$NAMESPACE" \
  --values "$VALUES_FILE"

echo "🌐 Waiting for external IP..."
kubectl get svc -n "$NAMESPACE" --watch
