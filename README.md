# Enterprise DevOps Deployment Toolkit

A hands-on lab project demonstrating a resilient delivery workflow for a small Flask service.

## What this repository demonstrates

- Automated tests with Pytest in GitHub Actions
- Container build with Docker
- Kubernetes Deployment, Service, health probes and resource limits
- Blue-green deployment using two Deployments and a stable Service selector
- Canary delivery example for ingress-nginx
- GitOps delivery example with Argo CD and Kustomize
- External secret synchronization template
- Backup and restore scripts plus disaster-recovery notes
- Deployment strategy trade-off analysis

## Quick start

Requirements: Python 3.11+ and Docker (optional).

```bash
python -m venv .venv
# Windows PowerShell: .venv\Scripts\Activate.ps1
# macOS/Linux: source .venv/bin/activate
pip install -r requirements-dev.txt
pytest -q
python -m flask --app app.main run --host 0.0.0.0 --port 8080
```

Open http://localhost:8080/ and check /health, /ready and /version.

Build and run the container:

```bash
docker build -t devops-demo:local .
docker run --rm -p 8080:8080 devops-demo:local
```

## Kubernetes staging

Update the image in `k8s/base/deployment.yaml` to an image you have built and pushed to a registry, then:

```bash
kubectl apply -k k8s/overlays/staging
kubectl rollout status deployment/devops-demo -n devops-demo
kubectl get pods,svc -n devops-demo
```

## Deployment strategies

- **Blue-green:** deploy the inactive colour, verify it, then change the stable Service selector. Use `scripts/switch-blue-green.sh blue|green`.
- **Canary:** the NGINX Ingress example routes a small percentage of requests to a canary Service. It requires ingress-nginx; adapt annotations for your ingress controller.
- **GitOps:** configure the repository URL in `k8s/gitops/application.yaml` and let Argo CD reconcile the Kustomize overlay.

## Secrets and recovery

Do not commit real credentials. `k8s/base/externalsecret.yaml.example` is a template for External Secrets Operator and requires a configured SecretStore. Read [SECURITY.md](docs/SECURITY.md) and [DISASTER-RECOVERY.md](docs/DISASTER-RECOVERY.md) before using this pattern outside a lab.

## Repository structure

```text
app/                  Flask demo service
tests/                Automated tests
.github/workflows/    CI and manual deployment workflows
k8s/base/             Reusable Kubernetes resources
k8s/overlays/         Staging, blue-green and canary examples
k8s/gitops/           Argo CD Application
scripts/              Rollout and backup/restore helpers
docs/                 Architecture, security, DR and trade-offs
```

## Before presenting this as completed work

Run the tests, inspect the Actions run, and deploy to a disposable Kubernetes cluster if available. Add genuine screenshots from your own run to `docs/evidence/`. The manifests are configuration examples; this repository does not claim a cloud cluster has already been provisioned.

## Evaluation checklist

- [ ] CI workflow passes on GitHub
- [ ] Docker image builds locally
- [ ] Kubernetes staging deployment becomes Ready
- [ ] Blue-green selector switch tested
- [ ] Canary ingress tested with ingress-nginx
- [ ] Argo CD sync tested
- [ ] SecretStore configured without committing secret values
- [ ] Backup and restore drill completed and documented

See [TRADE-OFFS.md](docs/TRADE-OFFS.md) for analysis of the approaches.
