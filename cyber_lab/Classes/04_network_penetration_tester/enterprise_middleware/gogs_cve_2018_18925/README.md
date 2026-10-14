# Gogs - CVE-2018-18925

## Overview
- **Vulnerability ID**: CVE-2018-18925
- **Application**: Gogs
- **Port Allocation**: Port 8412
- **CLI Shortcut**: `./lab start gogs-cve-2018-18925`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start gogs-cve-2018-18925

# View container status
./lab status

# Open interactive shell inside target
./lab shell gogs-cve-2018-18925
```

## Verification & Exploitation
```bash
curl http://localhost:8412/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
