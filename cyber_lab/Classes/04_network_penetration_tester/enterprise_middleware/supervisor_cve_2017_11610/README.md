# Supervisor - CVE-2017-11610

## Overview

- **Vulnerability ID**: CVE-2017-11610
- **Application**: Supervisor
- **Port Allocation**: Port 8506
- **CLI Shortcut**: `./lab start supervisor-cve-2017-11610`

## Vulnerability Description

Supervisor XML-RPC interface unauthenticated remote command execution vulnerability.

## Quick Start

```bash
# Start target environment
./lab start supervisor-cve-2017-11610

# View container status
./lab status

# Open interactive shell inside target
./lab shell supervisor-cve-2017-11610
```

## Verification & Exploitation

```bash
curl http://localhost:8506/
```

## Video Walkthrough

- Walkthrough: [Supervisor CVE-2017-11610 Security Assessment Walkthrough](https://www.youtube.com/watch?v=Bdwurohdhq4)
