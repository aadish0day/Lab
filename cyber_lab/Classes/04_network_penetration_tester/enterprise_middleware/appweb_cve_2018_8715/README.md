# Appweb - CVE-2018-8715

## Overview
- **Vulnerability ID**: CVE-2018-8715
- **Application**: Appweb
- **Port Allocation**: Port 8401
- **CLI Shortcut**: `./lab start appweb-cve-2018-8715`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start appweb-cve-2018-8715

# View container status
./lab status

# Open interactive shell inside target
./lab shell appweb-cve-2018-8715
```

## Verification & Exploitation
```bash
curl http://localhost:8401/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
