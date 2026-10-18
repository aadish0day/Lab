# Geoserver - CVE-2024-36401

## Overview

- **Vulnerability ID**: CVE-2024-36401
- **Application**: Geoserver
- **Port Allocation**: Port 8409
- **CLI Shortcut**: `./lab start geoserver-cve-2024-36401`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start geoserver-cve-2024-36401

# View container status
./lab status

# Open interactive shell inside target
./lab shell geoserver-cve-2024-36401
```

## Verification & Exploitation

```bash
curl http://localhost:8409/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
