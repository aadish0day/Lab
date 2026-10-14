# Kkfileview - 4.3-ZIPSLIP-RCE

## Overview
- **Vulnerability ID**: 4.3-ZIPSLIP-RCE
- **Application**: Kkfileview
- **Port Allocation**: Port 8379
- **CLI Shortcut**: `./lab start kkfileview-4.3-zipslip-rce`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start kkfileview-4.3-zipslip-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell kkfileview-4.3-zipslip-rce
```

## Verification & Exploitation
```bash
curl http://localhost:8379/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
