# Vite - CVE-2025-30208

## Overview
- **Vulnerability ID**: CVE-2025-30208
- **Application**: Vite
- **Port Allocation**: Port 8464
- **CLI Shortcut**: `./lab start vite-cve-2025-30208`

## Vulnerability Description
Vite dev server static asset handling directory traversal and source disclosure.

## Quick Start
```bash
# Start target environment
./lab start vite-cve-2025-30208

# View container status
./lab status

# Open interactive shell inside target
./lab shell vite-cve-2025-30208
```

## Verification & Exploitation
```bash
curl http://localhost:8464/
```

## Video Walkthrough
- Walkthrough: [Vite CVE-2025-30208 Security Assessment Walkthrough](https://www.youtube.com/watch?v=-xPMot9y76w)
