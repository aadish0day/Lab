# Flask - SSTI

## Overview
- **Vulnerability ID**: SSTI
- **Application**: Flask
- **Port Allocation**: Port 8283
- **CLI Shortcut**: `./lab start flask-ssti`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start flask-ssti

# View container status
./lab status

# Open interactive shell inside target
./lab shell flask-ssti
```

## Verification & Exploitation
```bash
curl http://localhost:8283/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
