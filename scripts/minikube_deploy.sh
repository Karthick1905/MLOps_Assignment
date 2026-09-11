#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${NAMESPACE:-ml-api-dev}"

if ! command -v minikube >/dev/null 2>&1; then
  echo "minikube is required"
  exit 1
fi

if ! minikube status >/dev/null 2>&1; then
  minikube start
fi

eval "$(minikube docker-env)"
docker build -t ml-api:local ./app

helm upgrade --install ml-api ./helm/ml-api \
  -f ./helm/ml-api/values-dev.yaml \
  --namespace "$NAMESPACE" \
  --create-namespace

kubectl rollout status deployment/ml-api -n "$NAMESPACE" --timeout=120s
kubectl get pods -n "$NAMESPACE"
kubectl get svc -n "$NAMESPACE"

echo
echo "Run this to access the API:"
echo "minikube service ml-api -n $NAMESPACE --url"
