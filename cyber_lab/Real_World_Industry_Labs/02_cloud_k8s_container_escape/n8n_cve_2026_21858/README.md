# N8n - CVE-2026-21858

## Overview
- **Vulnerability ID**: CVE-2026-21858
- **Application**: N8n
- **Port Allocation**: Port 8387
- **CLI Shortcut**: `./lab start n8n-cve-2026-21858`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start n8n-cve-2026-21858

# View container status
./lab status

# Open interactive shell inside target
./lab shell n8n-cve-2026-21858
```

## Verification & Exploitation
```bash
curl http://localhost:8387/
```

## Video Walkthrough
- Walkthrough: [n8n Workflow Automation Security Analysis](https://www.youtube.com/watch?v=1OvVwZgqnlo)
