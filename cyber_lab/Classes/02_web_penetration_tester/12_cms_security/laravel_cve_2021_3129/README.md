# Laravel - CVE-2021-3129

## Overview

- **Vulnerability ID**: CVE-2021-3129
- **Application**: Laravel
- **Port Allocation**: Port 8422
- **CLI Shortcut**: `./lab start laravel-cve-2021-3129`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start laravel-cve-2021-3129

# View container status
./lab status

# Open interactive shell inside target
./lab shell laravel-cve-2021-3129
```

## Verification & Exploitation

```bash
curl http://localhost:8422/
```

## Video Walkthrough

- Walkthrough: [Laravel Framework Security Vulnerability Analysis](https://www.youtube.com/watch?v=bZGDrNmCRWo)
