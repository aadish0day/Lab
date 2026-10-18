#!/usr/bin/env bash
# ==============================================================================
# DevSecOps Automated Security Scanning Pipeline
# Orchestrates Gitleaks (Secrets), Semgrep (SAST), and Trivy (SCA/IaC)
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$SCRIPT_DIR/target"
REPORTS_DIR="$SCRIPT_DIR/reports"

mkdir -p "$REPORTS_DIR"

echo "================================================================="
echo "       DevSecOps Automated Pipeline Execution"
echo "================================================================="
echo "[*] Target Directory:   $TARGET_DIR"
echo "[*] Reports Directory:  $REPORTS_DIR"
echo ""

# Stage 1: Secret Scanning with Gitleaks
echo "-----------------------------------------------------------------"
echo "[STAGE 1/3] Running Gitleaks Secrets Detection..."
echo "-----------------------------------------------------------------"
docker run --rm \
	-v "$TARGET_DIR":/src:ro \
	-v "$REPORTS_DIR":/reports \
	zricethezav/gitleaks:latest \
	detect --source=/src --report-format=json --report-path=/reports/gitleaks-report.json --no-git --verbose || true

if [ -f "$REPORTS_DIR/gitleaks-report.json" ]; then
	LEAKS_COUNT=$(grep -c '"Secret":' "$REPORTS_DIR/gitleaks-report.json" || true)
	echo "[+] Gitleaks Scan Finished! Leaks Found: $LEAKS_COUNT"
fi

# Stage 2: Static Application Security Testing (SAST) with Semgrep
echo ""
echo "-----------------------------------------------------------------"
echo "[STAGE 2/3] Running Semgrep SAST Code Analysis..."
echo "-----------------------------------------------------------------"
docker run --rm \
	-v "$TARGET_DIR":/src:ro \
	-v "$REPORTS_DIR":/reports \
	semgrep/semgrep:latest \
	semgrep scan --config auto --json -o /reports/semgrep-report.json /src || true

if [ -f "$REPORTS_DIR/semgrep-report.json" ]; then
	SEMGREP_COUNT=$(grep -o '"check_id":' "$REPORTS_DIR/semgrep-report.json" | wc -l || true)
	echo "[+] Semgrep Scan Finished! Code Flaws Found: $SEMGREP_COUNT"
fi

# Stage 3: Software Composition Analysis (SCA) & Misconfig with Trivy
echo ""
echo "-----------------------------------------------------------------"
echo "[STAGE 3/3] Running Trivy SCA & Container Misconfiguration Scan..."
echo "-----------------------------------------------------------------"
docker run --rm \
	-v "$TARGET_DIR":/src:ro \
	-v "$REPORTS_DIR":/reports \
	aquasec/trivy:latest \
	fs --format json -o /reports/trivy-report.json /src || true

if [ -f "$REPORTS_DIR/trivy-report.json" ]; then
	TRIVY_VULNS=$(grep -o '"VulnerabilityID":' "$REPORTS_DIR/trivy-report.json" | wc -l || true)
	echo "[+] Trivy Scan Finished! Dependency CVEs Found: $TRIVY_VULNS"
fi

echo ""
echo "================================================================="
echo "[+] DevSecOps Scanning Completed Successfully!"
echo "================================================================="
echo "Generated Reports in $REPORTS_DIR:"
ls -lh "$REPORTS_DIR"
echo ""
echo "To ingest findings into DefectDojo, run:"
echo "python3 import_to_defectdojo.py"
