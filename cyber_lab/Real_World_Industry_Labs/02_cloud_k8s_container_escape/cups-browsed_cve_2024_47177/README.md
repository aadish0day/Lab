# Cups-browsed - CVE-2024-47177

## Overview
- **Vulnerability ID**: CVE-2024-47177
- **Application**: Cups-browsed
- **Port Allocation**: Port 8391
- **CLI Shortcut**: `./lab start cups-browsed-cve-2024-47177`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start cups-browsed-cve-2024-47177

# View container status
./lab status

# Open interactive shell inside target
./lab shell cups-browsed-cve-2024-47177
```

## Verification & Exploitation
```bash
curl http://localhost:8391/
```

## Video Walkthrough
- Walkthrough: [CUPS IPP Remote Code Execution Walkthrough](https://www.youtube.com/watch?v=1OvVwZgqnlo)
