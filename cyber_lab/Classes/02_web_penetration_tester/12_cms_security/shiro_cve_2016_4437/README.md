# Shiro - CVE-2016-4437

## Overview

- **Vulnerability ID**: CVE-2016-4437
- **Application**: Shiro
- **Port Allocation**: Port 8472
- **CLI Shortcut**: `./lab start shiro-cve-2016-4437`

## Vulnerability Description

Apache Shiro default 'rememberMe' AES encryption key deserialization RCE vulnerability.

## Quick Start

```bash
# Start target environment
./lab start shiro-cve-2016-4437

# View container status
./lab status

# Open interactive shell inside target
./lab shell shiro-cve-2016-4437
```

## Verification & Exploitation

```bash
curl http://localhost:8472/
```

## Video Walkthrough

- Walkthrough: [Shiro CVE-2016-4437 Security Assessment Walkthrough](https://www.youtube.com/watch?v=1j1ORbmeJ7A)
