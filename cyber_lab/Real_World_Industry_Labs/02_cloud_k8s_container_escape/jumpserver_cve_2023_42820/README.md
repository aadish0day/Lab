# Jumpserver - CVE-2023-42820

## Overview
- **Vulnerability ID**: CVE-2023-42820
- **Application**: Jumpserver
- **Port Allocation**: Port 8374
- **CLI Shortcut**: `./lab start jumpserver-cve-2023-42820`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start jumpserver-cve-2023-42820

# View container status
./lab status

# Open interactive shell inside target
./lab shell jumpserver-cve-2023-42820
```

## Verification & Exploitation
```bash
curl http://localhost:8374/
```

## Video Walkthrough
- Walkthrough: [JumpServer Security and Auth Bypass Demo](https://www.youtube.com/watch?v=dn3DZHkcGh0)
