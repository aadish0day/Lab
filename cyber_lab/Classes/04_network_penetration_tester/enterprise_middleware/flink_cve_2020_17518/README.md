# Flink - CVE-2020-17518

## Overview

- **Vulnerability ID**: CVE-2020-17518
- **Application**: Flink
- **Port Allocation**: Port 8407
- **CLI Shortcut**: `./lab start flink-cve-2020-17518`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start flink-cve-2020-17518

# View container status
./lab status

# Open interactive shell inside target
./lab shell flink-cve-2020-17518
```

## Verification & Exploitation

```bash
curl http://localhost:8407/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
