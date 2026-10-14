# WordPress - CVE-2019-8942-RCE

## Overview
- **Vulnerability ID**: CVE-2019-8942
- **Application**: WordPress
- **Port Allocation**: Port 8509
- **CLI Shortcut**: `./lab start wordpress-cve-2019-8942-rce`

## Vulnerability Description
WordPress 5.0.0 remote code execution via crop-image post meta manipulation and path traversal.

## Quick Start
```bash
# Start target environment
./lab start wordpress-cve-2019-8942-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell wordpress-cve-2019-8942-rce
```

## Verification & Exploitation
```bash
curl http://localhost:8509/
```

## Video Walkthrough
- Walkthrough: [WordPress CVE-2019-8942-RCE Security Assessment Walkthrough](https://www.youtube.com/watch?v=DWnTxHpA61I)
