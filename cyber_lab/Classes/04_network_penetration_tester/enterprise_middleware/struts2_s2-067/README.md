# Struts2 - CVE-2024-53677

## Overview
- **Vulnerability ID**: CVE-2024-53677
- **Application**: Struts2
- **Port Allocation**: Port 8328
- **CLI Shortcut**: `./lab start struts2-s2-067`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-067

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-067
```

## Verification & Exploitation
```bash
curl http://localhost:8328/
```

## Video Walkthrough
- Walkthrough: [Apache Struts 2 OGNL Exploitation Demo](https://www.youtube.com/watch?v=aOU9DbRWw2k)
