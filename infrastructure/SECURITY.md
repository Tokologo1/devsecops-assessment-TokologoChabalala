# Security Posture & Decisions

## Base Images
- **Builder:** `maven:3.9.9-eclipse-temurin-17` (build stage only)
- **Runtime:** `eclipse-temurin:17-jre-alpine` (minimal footprint)
- No `:latest` tags; explicit versions to ensure reproducibility.

## Dependency Management
- Maven resolves deps in a dedicated cached layer (`dependency:go-offline`).
- CI scans recommended (e.g., OWASP Dependency-Check or Trivy filesystem scan).

## Runtime Security
- Non-root `app` user in final image.
- Read-only root filesystem with `tmpfs:/tmp`.
- Dropped all Linux capabilities; `no-new-privileges`.
- Healthchecks & resource limits (Compose/K8s).
- K8s securityContext: `runAsNonRoot`, `readOnlyRootFilesystem`, `allowPrivilegeEscalation: false`, `seccompProfile: RuntimeDefault`.

## Scanning Integration
- **Hadolint** for Dockerfile best practices.
- **kube-linter** for Kubernetes manifests.
- **Conftest/OPA** for custom policy gates (Docker/K8s/CI).
- **Gitleaks** for hardcoded secret detection.
- CI workflow runs all scanners on PRs and uploads reports.

## Handling False Positives
- Secrets: `gitleaks.toml` allowlist for docs/examples/tests.
- Policy exceptions: adjust `policy/*.rego` with clear comments & temporary waivers reviewed via PR.

## Quality Gates
- `scripts/validate.sh` fails on policy/linting violations.
- `scripts/scan-secrets.sh` fails on **HIGH-confidence** findings; MEDIUM/LOW reported for triage.
- CI job fails if any gate fails; artifacts (reports) available for review.

## Monitoring & Ops
- Recommend enabling runtime container scanning in cluster (Falco/OPA Gatekeeper).
- Centralize logs of CI runs; alert on suspicious triggers.
