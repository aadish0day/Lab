# Spring - CVE-2018-1270

## Overview
- **Vulnerability ID**: CVE-2018-1270
- **Application**: Spring
- **Port Allocation**: Port 8498
- **CLI Shortcut**: `./lab start spring-cve-2018-1270`

## Vulnerability Description
Spring Messaging STOMP protocol SpEL expression injection remote code execution.

## Quick Start
```bash
# Start target environment
./lab start spring-cve-2018-1270

# View container status
./lab status

# Open interactive shell inside target
./lab shell spring-cve-2018-1270
```

## Verification & Exploitation
```bash
curl http://localhost:8498/
```

## Video Walkthrough
- Walkthrough: [Spring CVE-2018-1270 Security Assessment Walkthrough](https://www.youtube.com/watch?v=97HQ_Y3DBbM)
