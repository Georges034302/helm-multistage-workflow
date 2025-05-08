#!/bin/bash

set -e

RELEASE_NAME="employee-app"
CHART_DIR="./employee-app"

echo "🚀 Deploying $RELEASE_NAME to AKS via Helm..."
helm upgrade --install "$RELEASE_NAME" "$CHART_DIR"

echo "🌐 Fetching external IP..."
kubectl get svc employee-frontend --watch
