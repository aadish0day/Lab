# Spring - CVE-2022-22965

## Overview
- **Vulnerability ID**: CVE-2022-22965
- **Application**: Spring
- **Port Allocation**: Port 8502
- **CLI Shortcut**: `./lab start spring-cve-2022-22965`

## Vulnerability Description
Spring Framework 'Spring4Shell' data binding class loader manipulation RCE.

## Quick Start
```bash
# Start target environment
./lab start spring-cve-2022-22965

# View container status
./lab status

# Open interactive shell inside target
./lab shell spring-cve-2022-22965
```

## Verification & Exploitation
```bash
curl http://localhost:8502/
```

## Video Walkthrough
- Walkthrough: [Spring CVE-2022-22965 Security Assessment Walkthrough](https://www.youtube.com/watch?v=9UAQ1VzSq8Q)
