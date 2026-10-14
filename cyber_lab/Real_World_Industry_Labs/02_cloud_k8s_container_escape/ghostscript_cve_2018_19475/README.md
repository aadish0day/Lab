# Ghostscript - CVE-2018-19475

## Overview
- **Vulnerability ID**: CVE-2018-19475
- **Application**: Ghostscript
- **Port Allocation**: Port 8395
- **CLI Shortcut**: `./lab start ghostscript-cve-2018-19475`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start ghostscript-cve-2018-19475

# View container status
./lab status

# Open interactive shell inside target
./lab shell ghostscript-cve-2018-19475
```

## Verification & Exploitation
```bash
curl http://localhost:8395/
```

## Video Walkthrough
- Walkthrough: [Ghostscript -dSAFER Bypass Walkthrough](https://www.youtube.com/watch?v=bZGDrNmCRWo)
