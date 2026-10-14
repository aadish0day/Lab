# Superset - CVE-2023-27524

## Overview
- **Vulnerability ID**: CVE-2023-27524
- **Application**: Superset
- **Port Allocation**: Port 8475
- **CLI Shortcut**: `./lab start superset-cve-2023-27524`

## Vulnerability Description
Apache Superset default SECRET_KEY flask session forgery administrative access vulnerability.

## Quick Start
```bash
# Start target environment
./lab start superset-cve-2023-27524

# View container status
./lab status

# Open interactive shell inside target
./lab shell superset-cve-2023-27524
```

## Verification & Exploitation
```bash
curl http://localhost:8475/
```

## Video Walkthrough
- Walkthrough: [Superset CVE-2023-27524 Security Assessment Walkthrough](https://www.youtube.com/watch?v=3A0vfCk4PWw)
