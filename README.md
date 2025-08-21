Usage
1. Clone repository (or place script in project root)
git clone https://assess.git
cd your-repo

2. Run the script
chmod +x security-scan.sh
./security-scan.sh

3. Script output

Docker/K8s/CI/CD validation:

[PASS] Dockerfile: No insecure practices found
[FAIL] deployment.yaml: Container image uses latest tag (non-pinned)
[PASS] Azure-Pipeline.yml: Config follows baseline


Secrets scan:

Secrets detected:
{
  "file": ".env",
  "line": 3,
  "description": "Potential API key",
  "entropy": 3.9
}


Reports saved in:

reports/docker-check.json
reports/k8s-check.json
reports/secrets-report.json

Customization

Modify security-scan.sh to include/exclude specific directories

Configure thresholds for secret detection confidence

Add additional rules for Dockerfile, Kubernetes manifests, and CI/CD policies

Example
# Run full scan
./security-scan.sh

# Scan only secrets
./security-scan.sh --secrets

# Scan only Kubernetes manifests
./security-scan.sh --k8s

# Scan only Dockerfiles
./security-scan.sh --docker
