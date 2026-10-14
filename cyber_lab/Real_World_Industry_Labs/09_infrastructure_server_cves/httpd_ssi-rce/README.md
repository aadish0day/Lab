# Httpd - SSI-RCE

## Overview
- **Vulnerability ID**: SSI-RCE
- **Application**: Httpd
- **Port Allocation**: Port 8369
- **CLI Shortcut**: `./lab start httpd-ssi-rce`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start httpd-ssi-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell httpd-ssi-rce
```

## Verification & Exploitation
```bash
curl http://localhost:8369/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
