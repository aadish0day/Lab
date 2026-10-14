# Php - 8.1-BACKDOOR

## Overview
- **Vulnerability ID**: 8.1-BACKDOOR
- **Application**: Php
- **Port Allocation**: Port 8291
- **CLI Shortcut**: `./lab start php-8.1-backdoor`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start php-8.1-backdoor

# View container status
./lab status

# Open interactive shell inside target
./lab shell php-8.1-backdoor
```

## Verification & Exploitation
```bash
curl http://localhost:8291/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
