#!/bin/bash
# scan-secrets.sh
# Scans project files for hardcoded secrets (API keys, passwords, tokens)

set -e

# Configuration
REPORT_FILE="secret-scan-report.json"
CONFIDENCE_THRESHOLD=0.7  # optional threshold for filtering low-confidence matches

echo "=== Starting Hardcoded Secret Scan ==="

# Check if gitleaks is installed
if ! command -v gitleaks >/dev/null 2>&1; then
    echo "Gitleaks not installed. Please install: https://github.com/gitleaks/gitleaks"
    exit 1
fi

# Run gitleaks scan
gitleaks detect \
    --source . \
    --report-format json \
    --report-path "$REPORT_FILE" \
    --redact

# Optional: filter results by confidence (if using a custom scanner that provides confidence)
# jq '[.[] | select(.entropy >= '$CONFIDENCE_THRESHOLD')]' "$REPORT_FILE" > "filtered-$REPORT_FILE"

echo "Scan complete. Report saved to $REPORT_FILE"

# Print summary
if [ -s "$REPORT_FILE" ]; then
    echo "Secrets detected:"
    jq '.[] | {file: .file, line: .line, description: .description, entropy: .entropy}' "$REPORT_FILE"
else
    echo "No hardcoded secrets detected."
fi
