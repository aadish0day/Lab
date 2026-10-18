# Glassfish - CVE-2017-1000028

## Overview

- **Vulnerability ID**: CVE-2017-1000028
- **Application**: Glassfish
- **Port Allocation**: Port 8410
- **CLI Shortcut**: `./lab start glassfish-cve-2017-1000028`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start glassfish-cve-2017-1000028

# View container status
./lab status

# Open interactive shell inside target
./lab shell glassfish-cve-2017-1000028
```

## Verification & Exploitation

```bash
curl http://localhost:8410/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
