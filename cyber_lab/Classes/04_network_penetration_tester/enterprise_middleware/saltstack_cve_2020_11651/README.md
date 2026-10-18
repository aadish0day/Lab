# SaltStack - CVE-2020-11651

## Overview

- **Vulnerability ID**: CVE-2020-11651
- **Application**: SaltStack
- **Port Allocation**: Port 8488
- **CLI Shortcut**: `./lab start saltstack-cve-2020-11651`

## Vulnerability Description

SaltStack Salt master ClearFuncs authentication bypass vulnerability allowing unauthenticated command execution.

## Quick Start

```bash
# Start target environment
./lab start saltstack-cve-2020-11651

# View container status
./lab status

# Open interactive shell inside target
./lab shell saltstack-cve-2020-11651
```

## Verification & Exploitation

```bash
curl http://localhost:8488/
```

## Video Walkthrough

- Walkthrough: [SaltStack CVE-2020-11651 Security Assessment Walkthrough](https://www.youtube.com/watch?v=6m58tAkw0FQ)
