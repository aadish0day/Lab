# Pgadmin - CVE-2023-5002

## Overview
- **Vulnerability ID**: CVE-2023-5002
- **Application**: Pgadmin
- **Port Allocation**: Port 8427
- **CLI Shortcut**: `./lab start pgadmin-cve-2023-5002`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start pgadmin-cve-2023-5002

# View container status
./lab status

# Open interactive shell inside target
./lab shell pgadmin-cve-2023-5002
```

## Verification & Exploitation
```bash
curl http://localhost:8427/
```

## Video Walkthrough
- Walkthrough: [pgAdmin PostgreSQL Web Management Security Walkthrough](https://www.youtube.com/watch?v=vmSTJI3gFSg)
