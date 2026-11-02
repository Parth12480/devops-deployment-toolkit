#!/usr/bin/env bash
set -euo pipefail
NAMESPACE="${1:-devops-demo}"
BACKUP_DIR="${BACKUP_DIR:-./backups}"
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$BACKUP_DIR"
kubectl get all,configmaps,ingress,pvc -n "$NAMESPACE" -o yaml > "$BACKUP_DIR/$NAMESPACE-$STAMP.yaml"
echo "Resource export saved. Persistent volume contents and Secret values are not included."
