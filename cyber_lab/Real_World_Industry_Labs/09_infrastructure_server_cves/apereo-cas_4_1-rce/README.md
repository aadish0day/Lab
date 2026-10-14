# Apereo-cas - 4.1-RCE

## Overview
- **Vulnerability ID**: 4.1-RCE
- **Application**: Apereo-cas
- **Port Allocation**: Port 8340
- **CLI Shortcut**: `./lab start apereo-cas-4.1-rce`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start apereo-cas-4.1-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell apereo-cas-4.1-rce
```

## Verification & Exploitation
```bash
curl http://localhost:8340/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
