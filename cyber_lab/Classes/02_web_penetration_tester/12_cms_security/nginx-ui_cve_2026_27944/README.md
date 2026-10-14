# Nginx-ui - CVE-2026-27944

## Overview
- **Vulnerability ID**: CVE-2026-27944
- **Application**: Nginx-ui
- **Port Allocation**: Port 8424
- **CLI Shortcut**: `./lab start nginx-ui-cve-2026-27944`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start nginx-ui-cve-2026-27944

# View container status
./lab status

# Open interactive shell inside target
./lab shell nginx-ui-cve-2026-27944
```

## Verification & Exploitation
```bash
curl http://localhost:8424/
```

## Video Walkthrough
- Walkthrough: [Nginx UI Security Analysis and Vulnerability Demo](https://www.youtube.com/watch?v=1OvVwZgqnlo)
