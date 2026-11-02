# Deployment strategy trade-offs

| Strategy | Advantages | Trade-offs |
|---|---|---|
| Rolling update | Built into Kubernetes; low extra capacity | Old and new versions coexist; rollback may not reverse data changes |
| Blue-green | Fast traffic switch; simple application rollback | Requires capacity for two versions; database compatibility still matters |
| Canary | Limits exposure and gathers production feedback | Requires traffic routing, metrics and enough traffic to draw conclusions |
| GitOps | Desired state is reviewable; drift can be corrected | Controller and Git repository become operational dependencies |

## How to measure effectiveness

Track change failure rate, lead time for changes, deployment frequency, mean time to restore, HTTP error rate, latency and rollback duration.

## Practical recommendation

Run tests and build immutable artifacts for every change. Use rolling updates for routine compatible releases, blue-green when a quick switch is worth the extra capacity, and canary when traffic can be split and monitored reliably. Use GitOps as the normal delivery path with a documented emergency procedure.

Database changes need their own compatibility plan. Expand-and-contract migrations are safer than assuming a deployment strategy can reverse schema changes.
