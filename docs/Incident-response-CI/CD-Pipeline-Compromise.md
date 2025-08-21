Here’s a structured Incident Response Analysis for a CI/CD pipeline compromise, tailored for GitHub Actions:

Incident Response Plan: CI/CD Pipeline Compromise
1️⃣ Preparation

Maintain up-to-date access logs, audit logs, and secrets rotation.

Ensure all secrets in GitHub Actions use GitHub Secrets; avoid hardcoding.

Enable branch protection rules (PR reviews, required status checks).

Keep team contact lists for incident communication.

2️⃣ Detection

Indicators of compromise:

Unexpected or suspicious commits in protected branches.

Unauthorized workflow runs or triggers.

Unexpected deployment events.

Security scanner alerts in the pipeline.

GitHub Actions log anomalies (failed checks, unknown runners).

Detection tools:

GitHub audit logs (Settings → Security → Audit Log).

GitHub Actions workflow run logs.

GitHub Advanced Security (if available) for secret scanning.

3️⃣ Containment

Immediate actions:

Pause deployments by disabling workflow triggers.

Revoke GitHub tokens or credentials potentially compromised.

Restrict branch access temporarily.

Isolate affected runners if using self-hosted runners.

Check recent merges/commits for malicious code changes.

4️⃣ Investigation

Identify who, what, when:

Which workflow ran suspiciously.

Which commit or PR introduced changes.

Check logs for artifacts or secrets accessed.

Confirm whether any secrets or production systems were accessed.

5️⃣ Eradication

Revert suspicious commits.

Rotate all secrets and tokens used in GitHub Actions.

Remove any unauthorized access (users, collaborators, runners).

Patch workflow vulnerabilities (e.g., using unverified actions).

6️⃣ Recovery

Re-enable workflows gradually.

Validate deployments in a staging environment before production.

Restore production code and secrets only after verification.

7️⃣ Lessons Learned / Post-Incident

Conduct a post-mortem:

How did the attacker gain access?

What workflow configurations were weak?

Were code reviews or branch protections bypassed?

Improvements:

Enable required reviews and signed commits.

Integrate security scanning in CI/CD for code and dependencies.

Monitor workflow runs and alerts in real-time.

Enforce least privilege on GitHub tokens and secrets.

8️⃣ Communication Plan Outline

Internal:

Notify DevOps/Security teams immediately.

Provide updates to stakeholders as investigation progresses.

External (if applicable):

Prepare messaging for clients if production systems were affected.

Coordinate with legal/security for breach reporting if required.