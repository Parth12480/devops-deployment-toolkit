# Disaster recovery plan

The sample Flask service is stateless. A real system must separately protect databases, object storage, persistent volumes, cluster configuration and encryption keys.

## Example objectives (targets only; not measured)

| Measure | Example target | Meaning |
|---|---:|---|
| RPO | 24 hours | Maximum acceptable data loss |
| RTO | 4 hours | Target service restoration time |
| Database backup | Daily | Encrypted backup stored outside the primary failure domain |
| Restore test | Monthly | Restore to an isolated environment and validate |

## Recovery checklist

1. Declare the incident and identify the affected service.
2. Select the last known-good image digest and Git commit.
3. Provision a clean cluster and required network/storage resources.
4. Restore secrets from the approved secret manager.
5. Apply the reviewed Kustomize overlay or allow Argo CD to reconcile it.
6. Restore database and persistent data from a verified backup.
7. Validate /health, /ready, /version, logs and key user journeys.
8. Shift traffic only after validation and monitor errors and latency.
9. Record actual recovery time, data-loss window and follow-up actions.

A Kubernetes YAML export is not a backup of persistent volume contents or secret values. Perform regular restore drills; an untested backup is only an assumption.
