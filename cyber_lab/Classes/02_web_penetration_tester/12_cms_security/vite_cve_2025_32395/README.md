# Vite - CVE-2025-32395

## Overview
- **Vulnerability ID**: CVE-2025-32395
- **Application**: Vite
- **Port Allocation**: Port 8465
- **CLI Shortcut**: `./lab start vite-cve-2025-32395`

## Vulnerability Description
Vite development middleware security bypass allowing arbitrary internal file read.

## Quick Start
```bash
# Start target environment
./lab start vite-cve-2025-32395

# View container status
./lab status

# Open interactive shell inside target
./lab shell vite-cve-2025-32395
```

## Verification & Exploitation
```bash
curl http://localhost:8465/
```

## Video Walkthrough
- Walkthrough: [Vite CVE-2025-32395 Security Assessment Walkthrough](https://www.youtube.com/watch?v=0-abhd-CLwQ)
