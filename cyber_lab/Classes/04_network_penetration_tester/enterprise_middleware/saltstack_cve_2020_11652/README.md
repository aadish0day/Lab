# SaltStack - CVE-2020-11652

## Overview
- **Vulnerability ID**: CVE-2020-11652
- **Application**: SaltStack
- **Port Allocation**: Port 8489
- **CLI Shortcut**: `./lab start saltstack-cve-2020-11652`

## Vulnerability Description
SaltStack Salt master arbitrary directory traversal and file write vulnerability.

## Quick Start
```bash
# Start target environment
./lab start saltstack-cve-2020-11652

# View container status
./lab status

# Open interactive shell inside target
./lab shell saltstack-cve-2020-11652
```

## Verification & Exploitation
```bash
curl http://localhost:8489/
```

## Video Walkthrough
- Walkthrough: [SaltStack CVE-2020-11652 Security Assessment Walkthrough](https://www.youtube.com/watch?v=6rZddmB0fug)
