#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-}"
NAMESPACE="${NAMESPACE:-devops-demo}"
if [[ "$TARGET" != "blue" && "$TARGET" != "green" ]]; then
  echo "Usage: $0 blue|green" >&2
  exit 2
fi
DEPLOYMENT="devops-demo-$TARGET"
kubectl rollout status "deployment/$DEPLOYMENT" -n "$NAMESPACE" --timeout=180s
READY="$(kubectl get deployment "$DEPLOYMENT" -n "$NAMESPACE" -o jsonpath='{.status.readyReplicas}')"
DESIRED="$(kubectl get deployment "$DEPLOYMENT" -n "$NAMESPACE" -o jsonpath='{.spec.replicas}')"
if [[ -z "$READY" || "$READY" != "$DESIRED" ]]; then
  echo "Not all $TARGET replicas are ready; traffic was not switched." >&2
  exit 1
fi
kubectl patch service devops-demo -n "$NAMESPACE" --type merge -p "{\"spec\":{\"selector\":{\"app\":\"devops-demo\",\"track\":\"$TARGET\"}}}"
echo "Production Service now routes to $TARGET."
