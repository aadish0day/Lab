# DevSecOps Automated Scanner Stack: SAST, SCA & Container Pipeline

## Overview

Modern software engineering requires shifting security left by embedding automated security tests directly into CI/CD build runners. This lab provides a production-grade multi-tool scanner harness integrating the industry's premier open-source DevSecOps tools:

1. **Gitleaks**: High-performance secret detection and regex token entropy scanner.
2. **Semgrep**: Fast, semantic Static Application Security Testing (SAST) analyzing Abstract Syntax Trees (ASTs).
3. **Trivy**: Comprehensive Software Composition Analysis (SCA), OS dependency vulnerability scanner, and container/Dockerfile misconfiguration auditor.
4. **DefectDojo Ingestion**: Centralized vulnerability management, deduplication, and risk scoring dashboard.

- **Vulnerable Target App Port**: [http://localhost:8102](http://localhost:8102)
- **DefectDojo Dashboard Port**: `http://localhost:8098` (via `./lab start threat-intel`)
- **Container Names**: `cyberlab_devsecops_pipeline`, `cyberlab_pipeline_target`
- **Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/devsecops_scanner_pipeline`

---

## Pipeline Architecture & Data Flow

```
+--------------------------------------------------------------------------+
| Developer Commit / CI Trigger                                            |
+--------------------------------------------------------------------------+
       |
       +---> [1] Gitleaks (Secrets)       ---> reports/gitleaks-report.json
       |
       +---> [2] Semgrep (SAST Engine)    ---> reports/semgrep-report.json
       |
       +---> [3] Trivy (SCA & Container)  ---> reports/trivy-report.json
       |
       v
+--------------------------------------------------------------------------+
| DefectDojo API v2 Ingestion: import_to_defectdojo.py                     |
| Deduplication, Risk Matrix, SLA Tracking, JIRA Integration               |
+--------------------------------------------------------------------------+
```

---

## Quick Start & Running Scans

### 1. Launch the Lab Stack

```bash
cd Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/devsecops_scanner_pipeline

# Start the pipeline runner and vulnerable target web application
docker compose up -d
```

### 2. Execute the Automated 3-Stage Scan

Run the automated orchestrator script to execute all scanners against `./target` and output structured JSON reports in `./reports/`:

```bash
./run_pipeline.sh
```

### 3. Review Generated Findings

Inspect findings directly in the terminal:

```bash
# View detected secrets (AWS keys, Stripe tokens, DB URLs)
jq '.[] | {RuleID, Secret, File: .File}' reports/gitleaks-report.json

# View SAST findings (SQL injection, command execution, unsafe YAML deserialization)
jq '.results[] | {check_id, message: .extra.message, path}' reports/semgrep-report.json

# View open dependency CVEs (PyYAML, urllib3, requests)
jq '.Results[].Vulnerabilities[]? | {VulnerabilityID, PkgName, InstalledVersion, Severity}' reports/trivy-report.json
```

---

## Pipeline Stages Breakdown

### Stage 1: Secret Scanning (Gitleaks)
- **Target**: Prevents hardcoded credentials from entering git repositories or Docker builds.
- **Rules Tested**:
  - AWS Access Key ID (`AKIA...`) and Secret Access Key
  - Stripe Live API Keys (`sk_live_...`)
  - Postgres database connection strings with passwords
- **Execution Command**:
  ```bash
  docker run --rm -v $(pwd)/target:/src:ro zricethezav/gitleaks:latest \
    detect --source=/src --report-format=json --report-path=/reports/gitleaks.json --no-git
  ```

### Stage 2: Static Application Security Testing - SAST (Semgrep)
- **Target**: AST pattern matching on application code without compiling or running the app.
- **Flaws Detected in `./target/app.py`**:
  - `python.lang.security.audit.sqli.direct-quote-concat`: SQL string concatenation in `cursor.execute()`.
  - `python.lang.security.audit.system-call-os-system`: Unsanitized input passed into `os.system()`.
  - `python.lang.security.deserialization.avoid-pyyaml-load`: Unsafe `yaml.load()` allowing remote code execution.
- **Execution Command**:
  ```bash
  docker run --rm -v $(pwd)/target:/src:ro semgrep/semgrep:latest \
    semgrep scan --config auto --json -o /reports/semgrep.json /src
  ```

### Stage 3: Software Composition Analysis & Misconfiguration (Trivy)
- **Target**: Scans package manifests (`requirements.txt`, `package.json`, `pom.xml`) against OSV/NVD databases and checks `Dockerfile` against CIS benchmarks.
- **Flaws Detected**:
  - `CVE-2020-14343`: PyYAML 5.1 arbitrary code execution via FullLoader.
  - `CVE-2018-18074`: Requests 2.19.1 credential leak on HTTP 302 redirect.
  - `AVD-DS-0002`: Missing `USER` instruction in `Dockerfile` (runs as root).
- **Execution Command**:
  ```bash
  docker run --rm -v $(pwd)/target:/src:ro aquasec/trivy:latest \
    fs --format json -o /reports/trivy.json /src
  ```

---

## Ingesting Findings into DefectDojo

DefectDojo provides a unified pane of glass for consolidating findings from over 150 security scanners.

1. Start DefectDojo from the root lab directory if not already running:
   ```bash
   ./lab start threat-intel
   ```
2. Navigate to [http://localhost:8098](http://localhost:8098) and log in (default credentials: `admin` / `admin`).
3. Click your profile avatar in the upper right -> **API v2 Key** -> copy your token.
4. Run the automated ingestion script:
   ```bash
   python3 import_to_defectdojo.py --url http://localhost:8098 --key <YOUR_API_KEY> --engagement 1
   ```
5. View the unified vulnerability dashboard with deduplication, severity prioritization, and remediation tracking!

---

## Production CI/CD Integration Examples

### GitHub Actions Workflow (`.github/workflows/devsecops.yml`)
```yaml
name: DevSecOps CI Pipeline
on: [push, pull_request]

jobs:
  security-gate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Gitleaks Secrets Check
        uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: Semgrep SAST Scan
        run: |
          python3 -m pip install semgrep
          semgrep scan --config auto --error

      - name: Trivy Vulnerability Scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          severity: 'HIGH,CRITICAL'
          exit-code: '1'
```

---

## Verified YouTube Walkthroughs & Lectures

All video links have been verified active via YouTube oEmbed API:

- [Madhukar Reddy - DevSecOps Full Project: Gitleaks + SonarQube + Trivy + Checkov + ZAP on AWS](https://www.youtube.com/watch?v=e8sQkmj3N1w) — Complete end-to-end 7-stage DevSecOps pipeline with secret scanning and vulnerability gates.
- [Oluwaseun Alausa - DevSecOps Ep. 8: SAST Scanning in CI/CD with Semgrep & njsscan](https://www.youtube.com/watch?v=pNeL1-Z6uyg) — Practical setup of Semgrep semantic analysis in automated build pipelines.
- [Yash Academy - Episode 04: Git Security for DevSecOps | Gitleaks, Pre-Commit Hooks, Branch Protection](https://www.youtube.com/watch?v=NwpnQU45lQ4) — Hands-on implementation of Gitleaks locally and inside automated CI triggers.
- [Cloudamy - Build a DevSecOps Pipeline with GitLab CI/CD: Trivy + SonarQube + Quality Gate](https://www.youtube.com/watch?v=2F6AoV3BtNA) — In-depth tutorial integrating Trivy SCA and container image scanning.
- [Yash Academy - Episode 5: Build a Production DevSecOps CI Pipeline | Security Scanning + Caching](https://www.youtube.com/watch?v=E7yX3H3epMM) — Enterprise CI/CD security patterns with matrix builds and vulnerability reporting.
- [DefectDojo - Introduction to DefectDojo](https://www.youtube.com/watch?v=5AeQgI1eTKk) — Official introduction to managing vulnerabilities, engagements, and scanner ingestion.
- [media.ccc.de - 38C3: Vulnerability Management with DefectDojo](https://www.youtube.com/watch?v=uNMnk6X8e-E) — Real-world deployment architecture and security operations center (SOC) integration.

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
cd Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/devsecops_scanner_pipeline && docker compose down
```
