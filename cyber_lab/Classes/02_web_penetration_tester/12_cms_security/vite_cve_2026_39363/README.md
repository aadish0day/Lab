# Vite - CVE-2026-39363

## Overview
- **Vulnerability ID**: CVE-2026-39363
- **Application**: Vite
- **Port Allocation**: Port 8466
- **CLI Shortcut**: `./lab start vite-cve-2026-39363`

## Vulnerability Description
Vite hot-module-reload server protocol manipulation and arbitrary source file leakage.

## Quick Start
```bash
# Start target environment
./lab start vite-cve-2026-39363

# View container status
./lab status

# Open interactive shell inside target
./lab shell vite-cve-2026-39363
```

## Verification & Exploitation
```bash
curl http://localhost:8466/
```

## Video Walkthrough
- Walkthrough: [Vite CVE-2026-39363 Security Assessment Walkthrough](https://www.youtube.com/watch?v=0CFWHjc4B-I)
