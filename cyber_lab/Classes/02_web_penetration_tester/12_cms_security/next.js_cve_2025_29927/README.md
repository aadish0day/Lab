# Next.js - CVE-2025-29927

## Overview
- **Vulnerability ID**: CVE-2025-29927
- **Application**: Next.js
- **Port Allocation**: Port 8423
- **CLI Shortcut**: `./lab start next.js-cve-2025-29927`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start next.js-cve-2025-29927

# View container status
./lab status

# Open interactive shell inside target
./lab shell next.js-cve-2025-29927
```

## Verification & Exploitation
```bash
curl http://localhost:8423/
```

## Video Walkthrough
- Walkthrough: [Next.js Middleware Security and SSRF Analysis](https://www.youtube.com/watch?v=1OvVwZgqnlo)
