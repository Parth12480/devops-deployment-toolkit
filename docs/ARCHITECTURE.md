# Architecture

Developer changes enter GitHub through a pull request. GitHub Actions runs tests, a Bandit security scan and a Docker build. A reviewed commit and immutable image are then promoted to Kubernetes. Argo CD watches the Kustomize overlay in Git and reconciles the live cluster.

The Flask app stays deliberately small so the lab focuses on delivery engineering. `/health` is for liveness, `/ready` is for readiness, and `/version` reports the configured version.

For production, extend CI with dependency and image vulnerability scanning, SBOM generation, image signing and verification, policy checks, and integration tests. Build an image once and promote the same digest through environments rather than rebuilding different artifacts.
