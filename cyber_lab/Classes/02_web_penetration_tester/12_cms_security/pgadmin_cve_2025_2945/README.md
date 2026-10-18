# Pgadmin - CVE-2025-2945

## Overview

- **Vulnerability ID**: CVE-2025-2945
- **Application**: Pgadmin
- **Port Allocation**: Port 8429
- **CLI Shortcut**: `./lab start pgadmin-cve-2025-2945`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start pgadmin-cve-2025-2945

# View container status
./lab status

# Open interactive shell inside target
./lab shell pgadmin-cve-2025-2945
```

## Verification & Exploitation

```bash
curl http://localhost:8429/
```

## Video Walkthrough

- Walkthrough: [pgAdmin PostgreSQL Web Management Security Walkthrough](https://www.youtube.com/watch?v=vmSTJI3gFSg)
