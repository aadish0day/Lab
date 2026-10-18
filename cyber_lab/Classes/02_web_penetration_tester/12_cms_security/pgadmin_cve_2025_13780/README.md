# Pgadmin - CVE-2025-13780

## Overview

- **Vulnerability ID**: CVE-2025-13780
- **Application**: Pgadmin
- **Port Allocation**: Port 8428
- **CLI Shortcut**: `./lab start pgadmin-cve-2025-13780`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start pgadmin-cve-2025-13780

# View container status
./lab status

# Open interactive shell inside target
./lab shell pgadmin-cve-2025-13780
```

## Verification & Exploitation

```bash
curl http://localhost:8428/
```

## Video Walkthrough

- Walkthrough: [pgAdmin PostgreSQL Web Management Security Walkthrough](https://www.youtube.com/watch?v=vmSTJI3gFSg)
