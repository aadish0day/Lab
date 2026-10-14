# Redis - 4-UNACC

## Overview
- **Vulnerability ID**: 4-UNACC
- **Application**: Redis
- **Port Allocation**: Port 8319
- **CLI Shortcut**: `./lab start redis-4-unacc`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start redis-4-unacc

# View container status
./lab status

# Open interactive shell inside target
./lab shell redis-4-unacc
```

## Verification & Exploitation
```bash
curl http://localhost:8319/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
