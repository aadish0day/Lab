# SaltStack - CVE-2020-16846

## Overview
- **Vulnerability ID**: CVE-2020-16846
- **Application**: SaltStack
- **Port Allocation**: Port 8490
- **CLI Shortcut**: `./lab start saltstack-cve-2020-16846`

## Vulnerability Description
SaltStack Salt-API unauthenticated shell command injection via SSH key generation endpoint.

## Quick Start
```bash
# Start target environment
./lab start saltstack-cve-2020-16846

# View container status
./lab status

# Open interactive shell inside target
./lab shell saltstack-cve-2020-16846
```

## Verification & Exploitation
```bash
curl http://localhost:8490/
```

## Video Walkthrough
- Walkthrough: [SaltStack CVE-2020-16846 Security Assessment Walkthrough](https://www.youtube.com/watch?v=7-6iRTQ49_Q)
