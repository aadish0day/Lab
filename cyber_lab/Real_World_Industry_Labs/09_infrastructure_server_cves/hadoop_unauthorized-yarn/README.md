# Hadoop - UNAUTHORIZED-YARN

## Overview
- **Vulnerability ID**: UNAUTHORIZED-YARN
- **Application**: Hadoop
- **Port Allocation**: Port 8365
- **CLI Shortcut**: `./lab start hadoop-unauthorized-yarn`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start hadoop-unauthorized-yarn

# View container status
./lab status

# Open interactive shell inside target
./lab shell hadoop-unauthorized-yarn
```

## Verification & Exploitation
```bash
curl http://localhost:8365/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
