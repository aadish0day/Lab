# Metabase - CVE-2023-38646

## Overview

- **Vulnerability ID**: CVE-2023-38646
- **Application**: Metabase
- **Port Allocation**: Port 8385
- **CLI Shortcut**: `./lab start metabase-cve-2023-38646`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start metabase-cve-2023-38646

# View container status
./lab status

# Open interactive shell inside target
./lab shell metabase-cve-2023-38646
```

## Verification & Exploitation

```bash
curl http://localhost:8385/
```

## Video Walkthrough

- Walkthrough: [Metabase Security Vulnerability Walkthrough](https://www.youtube.com/watch?v=vmSTJI3gFSg)
