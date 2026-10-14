# OWASP WrongSecrets: Modern Secret Management Vulnerabilities

## Overview

**OWASP WrongSecrets** (created by Jeroen Willemsen and the OWASP Foundation) is an intentionally vulnerable gamified application illustrating how developers, DevOps engineers, and cloud architects incorrectly store, manage, and leak secrets across the entire modern software delivery lifecycle.

From hardcoded API keys and Docker layer caching flaws to Kubernetes ConfigMap exposure, HashiCorp Vault misconfigurations, and cloud secret manager anti-patterns, this lab covers real-world leakage mechanisms and modern defenses.

- **Web Application URL**: [http://localhost:8100](http://localhost:8100)
- **MCP Server Port**: `8101` (for Challenge 60 AI/MCP secrets)
- **Container Name**: `cyberlab_wrongsecrets`
- **Docker Image**: `jeroenwillemsen/wrongsecrets:latest-no-vault`
- **Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/wrongsecrets`

---

## Secret Storage Threat Vectors & Architecture

Secrets are commonly leaked across five key operational layers:

```
+--------------------------------------------------------------------------+
| 1. Codebase Layer     : Hardcoded constants, git commits, .env files     |
| 2. Image Layer        : Docker build cache, intermediate RUN layers      |
| 3. Runtime Container  : /proc/self/environ, process dumps, crash logs    |
| 4. Orchestration (K8s): Base64 etcd secrets, ConfigMap confusion         |
| 5. Cloud & Vault      : Overprivileged IAM, static tokens, lack of OIDC  |
+--------------------------------------------------------------------------+
```

### Running the Lab

```bash
cd Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/wrongsecrets

# Start the lab container
docker compose up -d

# Check logs
docker logs -f cyberlab_wrongsecrets
```
Open [http://localhost:8100](http://localhost:8100) in your browser to begin the interactive exercises.

---

## Core Challenge Domains & Exploitation Guides

### 1. Secrets Hardcoded in Source Code (Challenges 1 & 2)
- **Mechanism**: Developers embed raw API keys, passwords, or tokens directly in application logic or source repositories.
- **Exploitation**:
  1. Inspect source code repositories using code search or automated SAST:
     ```bash
     grep -rE "(password|secret|api_key|token)\s*=\s*['\"][^'\"]+" .
     ```
  2. Check Git history for secrets that were "deleted" in subsequent commits:
     ```bash
     git log -p -S "SECRET"
     ```

### 2. Secrets in Docker Container Layers (Challenges 3 & 4)
- **Mechanism**: Adding files in one `RUN` step and deleting them in a later `RUN` step does NOT remove them from earlier image layers.
- **Exploitation**:
  1. Inspect the image history without truncation:
     ```bash
     docker history --no-trunc jeroenwillemsen/wrongsecrets:latest-no-vault
     ```
  2. Use `dive` or export container tarballs to extract earlier layer files:
     ```bash
     docker save jeroenwillemsen/wrongsecrets:latest-no-vault -o image.tar
     tar -xvf image.tar
     # Search uncompressed layer archives for credentials
     find . -name "layer.tar" -exec tar -tvf {} \;
     ```

### 3. Secrets Stored in Environment Variables (Challenge 5)
- **Mechanism**: Passing credentials via `-e` or Docker Compose environment blocks. Environment variables are readable by any process inside the container, leaked in `/proc/*/environ`, and often logged by APM tools or crash handlers.
- **Exploitation**:
  1. Inspect environment variables of PID 1:
     ```bash
     docker exec cyberlab_wrongsecrets strings /proc/1/environ | grep -i SECRET
     ```
  2. Inspect container metadata via Docker CLI:
     ```bash
     docker inspect cyberlab_wrongsecrets | jq '.[0].Config.Env'
     ```

### 4. Secrets in Kubernetes ConfigMaps & Secrets (Challenges 6 & 7)
- **Mechanism**: Storing secrets in `ConfigMaps` (which are unencrypted plain text) or assuming `Kubernetes Secrets` are encrypted by default (they are merely Base64-encoded in `etcd` unless KMS envelope encryption is active).
- **Exploitation**:
  1. Base64 is encoding, not encryption:
     ```bash
     echo "Y3liZXJsYWJfc2VjcmV0X2ZsYWdfNDM5MDE=" | base64 -d
     # cyberlab_k8s_secret_flag_43901
     ```
  2. Dumping pod mounted volume tokens:
     ```bash
     cat /var/run/secrets/kubernetes.io/serviceaccount/token
     ```

### 5. Secrets in HashiCorp Vault & Dynamic Engines
- **Mechanism**: Storing static root tokens on disks, using long-lived AppRole SecretIDs without CIDR binding, or exposing unauthenticated Vault development servers (`vault server -dev`).
- **Remediation**:
  - Leverage dynamic database credentials with short TTLs (15 minutes).
  - Enforce Transit Secrets Engine for envelope cryptography.
  - Authenticate Kubernetes workloads using Kubernetes ServiceAccount JWT verification (`vault auth enable kubernetes`).

### 6. Reverse Engineering Binaries & Obfuscated Secrets
- **Mechanism**: Embedding secrets into compiled C/Go/Rust binaries assuming compilation hides the string.
- **Exploitation**:
  ```bash
  strings ./target_binary | grep -E "^[A-Za-z0-9_-]{20,}$"
  # Or inspect disassembly in Ghidra / Radare2
  ```

---

## Defensive Engineering Best Practices

1. **Shift Left with Pre-Commit Hooks**:
   Block secret commits at the developer workstation before reaching remote repositories:
   ```bash
   # .pre-commit-config.yaml
   repos:
     - repo: https://github.com/gitleaks/gitleaks
       rev: v8.18.2
       hooks:
         - id: gitleaks
   ```
2. **Workload Identity Federation (OIDC)**:
   Eliminate static cloud credentials (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) in CI/CD pipelines. Use OpenID Connect to request ephemeral, short-lived tokens from AWS STS, GCP STS, or Azure AD.
3. **External Secrets Operator (ESO)**:
   Synchronize secrets into Kubernetes dynamically from AWS Secrets Manager, HashiCorp Vault, or Azure Key Vault without storing credentials in GitOps repos.
4. **Multi-Stage Docker Builds**:
   Ensure build-time secrets and compile tools are discarded in intermediate stages and never copied to final runtime images:
   ```dockerfile
   FROM golang:1.21 AS builder
   ARG SECRET_TOKEN
   RUN build.sh

   FROM alpine:3.19
   COPY --from=builder /bin/app /bin/app
   USER 10001
   ENTRYPOINT ["/bin/app"]
   ```

---

## Verified YouTube Walkthroughs & Lectures

All video links have been verified active via YouTube oEmbed API:

- [GitGuardian - WrongSecrets Demo: How NOT to Store Secrets with Jeroen Willemsen](https://www.youtube.com/watch?v=nqzxpgvLEv4) — Live demonstration by project founder Jeroen Willemsen breaking down common secret pitfalls.
- [Open Security Summit - OWASP WrongSecrets: A Journey into Secret Management Failures](https://www.youtube.com/watch?v=-xPMot9y76w) — Architectural presentation on container, cloud, and K8s secret vulnerabilities.
- [OWASP Bay Area - OWASP WrongSecrets: How to NOT Manage Your Secrets](https://www.youtube.com/watch?v=oRUPVhp1Bfw) — In-depth conference talk on reversing secrets in layers, env vars, and binaries.
- [OWASP Spotlight - Project 31: OWASP WrongSecrets with Vandana Verma](https://www.youtube.com/watch?v=inSkNPLDlWo) — Official OWASP Spotlight exploring setup, challenges, and contribution guidelines.

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
cd Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/wrongsecrets && docker compose down
```
