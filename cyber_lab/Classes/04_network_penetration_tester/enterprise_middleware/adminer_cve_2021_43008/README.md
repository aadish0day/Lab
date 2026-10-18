# Adminer - CVE-2021-43008

## Overview

- **Vulnerability ID**: CVE-2021-43008
- **Application**: Adminer
- **Port Allocation**: Port 8399
- **CLI Shortcut**: `./lab start adminer-cve-2021-43008`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start adminer-cve-2021-43008

# View container status
./lab status

# Open interactive shell inside target
./lab shell adminer-cve-2021-43008
```

## Verification & Exploitation

```bash
curl http://localhost:8399/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
