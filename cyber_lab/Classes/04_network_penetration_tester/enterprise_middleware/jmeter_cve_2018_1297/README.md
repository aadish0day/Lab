# Jmeter - CVE-2018-1297

## Overview

- **Vulnerability ID**: CVE-2018-1297
- **Application**: Jmeter
- **Port Allocation**: Port 8421
- **CLI Shortcut**: `./lab start jmeter-cve-2018-1297`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start jmeter-cve-2018-1297

# View container status
./lab status

# Open interactive shell inside target
./lab shell jmeter-cve-2018-1297
```

## Verification & Exploitation

```bash
curl http://localhost:8421/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
