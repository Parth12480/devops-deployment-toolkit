# Security notes

This is a learning example, not a complete production security baseline.

- The container runs as a non-root user.
- Kubernetes drops Linux capabilities, disallows privilege escalation and uses a read-only root filesystem.
- CI has read-only repository permissions.
- Never commit passwords, API keys, kubeconfigs, private keys or .env files.
- Use a cloud secret manager and External Secrets Operator for secret delivery.
- In production, pin GitHub Actions to full commit SHAs, enable branch protection, scan dependencies and images, generate an SBOM, use short-lived workload identity, and restrict deployment permissions.

If a credential is committed, revoke or rotate it immediately. Removing the file from the latest commit does not invalidate a leaked secret.
