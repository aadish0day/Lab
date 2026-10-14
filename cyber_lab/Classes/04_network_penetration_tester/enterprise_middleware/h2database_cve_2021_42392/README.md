# H2database - CVE-2021-42392

## Overview
- **Vulnerability ID**: CVE-2021-42392
- **Application**: H2database
- **Port Allocation**: Port 8413
- **CLI Shortcut**: `./lab start h2database-cve-2021-42392`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start h2database-cve-2021-42392

# View container status
./lab status

# Open interactive shell inside target
./lab shell h2database-cve-2021-42392
```

## Verification & Exploitation
```bash
curl http://localhost:8413/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
