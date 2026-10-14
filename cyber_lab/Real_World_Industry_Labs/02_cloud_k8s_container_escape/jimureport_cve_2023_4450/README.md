# Jimureport - CVE-2023-4450

## Overview
- **Vulnerability ID**: CVE-2023-4450
- **Application**: Jimureport
- **Port Allocation**: Port 8373
- **CLI Shortcut**: `./lab start jimureport-cve-2023-4450`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start jimureport-cve-2023-4450

# View container status
./lab status

# Open interactive shell inside target
./lab shell jimureport-cve-2023-4450
```

## Verification & Exploitation
```bash
curl http://localhost:8373/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
