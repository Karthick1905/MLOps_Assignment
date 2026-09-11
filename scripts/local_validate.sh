#!/usr/bin/env bash
set -euo pipefail

echo "Running Python tests..."
(
  cd app
  python -m pytest -q
)

echo "Running Helm lint..."
helm lint ./helm/ml-api

for env in dev staging prod; do
  echo "Rendering $env..."
  helm template ml-api ./helm/ml-api \
    -f "./helm/ml-api/values-${env}.yaml" >/dev/null
done

echo "Validation completed successfully."
