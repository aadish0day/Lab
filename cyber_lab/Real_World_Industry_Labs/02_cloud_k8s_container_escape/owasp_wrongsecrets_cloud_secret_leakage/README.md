# OWASP-WrongSecrets - Cloud-Secret-Leakage

## Overview

- **Vulnerability ID**: WRONGSECRETS
- **Application**: OWASP-WrongSecrets
- **Port Allocation**: Port 8481
- **CLI Shortcut**: `./lab start owasp-wrongsecrets-cloud-secret-leakage`

## Vulnerability Description

OWASP WrongSecrets vulnerability lab covering hardcoded secrets, container env leaks, and vault flaws.

## Quick Start

```bash
# Start target environment
./lab start owasp-wrongsecrets-cloud-secret-leakage

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-wrongsecrets-cloud-secret-leakage
```

## Verification & Exploitation

```bash
curl http://localhost:8481/
```

## Video Walkthrough

- Walkthrough: [OWASP-WrongSecrets Cloud-Secret-Leakage Security Assessment Walkthrough](https://www.youtube.com/watch?v=4t4kBkMsDbQ)
