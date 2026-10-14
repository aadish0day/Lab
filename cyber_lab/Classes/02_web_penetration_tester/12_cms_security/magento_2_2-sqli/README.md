# Magento - 2.2-SQLI

## Overview
- **Vulnerability ID**: 2.2-SQLI
- **Application**: Magento
- **Port Allocation**: Port 8289
- **CLI Shortcut**: `./lab start magento-2.2-sqli`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start magento-2.2-sqli

# View container status
./lab status

# Open interactive shell inside target
./lab shell magento-2.2-sqli
```

## Verification & Exploitation
```bash
curl http://localhost:8289/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
