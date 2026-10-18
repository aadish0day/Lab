# Polkit - CVE-2021-4034

## Overview

- **Vulnerability ID**: CVE-2021-4034
- **Application**: Polkit
- **Port Allocation**: Port 8433
- **CLI Shortcut**: `./lab start polkit-cve-2021-4034`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start polkit-cve-2021-4034

# View container status
./lab status

# Open interactive shell inside target
./lab shell polkit-cve-2021-4034
```

## Verification & Exploitation

```bash
curl http://localhost:8433/
```

## Video Walkthrough

- Walkthrough: [Polkit PwnKit Local Privilege Escalation Demo](https://www.youtube.com/watch?v=MiaEWNruYdI)
