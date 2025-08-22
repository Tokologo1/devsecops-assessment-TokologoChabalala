# Container Security Decisions

## Base Images
- Backend: `maven:3.9.9-eclipse-temurin-17` (build only), `eclipse-temurin:17-jre-alpine` (runtime).
- Frontend: `node:20-alpine` (build only), `nginx:alpine` (runtime).
- Avoid `:latest`; pin versions for reproducibility.

## Dependency Management
- Maven `dependency:go-offline` for cache repeatability.
- `npm ci` to ensure lockfile integrity.

## Runtime Hardening
- Run as **non-root** user in both images.
- **read-only** filesystem and **tmpfs** for `/tmp` (Java) via Compose/K8s.
- Drop **all Linux capabilities**; set **no-new-privileges**.
- Health checks for both services.
- Network split: API and static web served by separate containers.

## Scanning
- **Trivy** on images; fail build on HIGH/CRITICAL.
- **Gitleaks** for secrets; fail on confirmed leaks.
- **kube-linter** for K8s manifest misconfig.
- Optional SBOM (Syft) for compliance.

## Secure Deployment
- Docker Compose: enforces read-only, caps, nnP, resources.
- K8s (if used): set `runAsNonRoot`, `readOnlyRootFilesystem`, `allowPrivilegeEscalation: false`, `seccompProfile: RuntimeDefault`, resource requests/limits, liveness/readiness probes.

## Operations
- Rotate secrets; never bake secrets into images.
- Keep images updated; rebuild on base image updates.
