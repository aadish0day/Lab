# WordPress - CVE-2026-63030

## Overview
- **Vulnerability ID**: CVE-2026-63030
- **Application**: WordPress
- **Port Allocation**: Port 8467
- **CLI Shortcut**: `./lab start wordpress-cve-2026-63030`

## Vulnerability Description
WordPress core input validation flaw allowing unauthenticated remote execution.

## Quick Start
```bash
# Start target environment
./lab start wordpress-cve-2026-63030

# View container status
./lab status

# Open interactive shell inside target
./lab shell wordpress-cve-2026-63030
```

## Verification & Exploitation
```bash
curl http://localhost:8467/
```

## Video Walkthrough
- Walkthrough: [WordPress CVE-2026-63030 Security Assessment Walkthrough](https://www.youtube.com/watch?v=0KYDTt5DiNM)
