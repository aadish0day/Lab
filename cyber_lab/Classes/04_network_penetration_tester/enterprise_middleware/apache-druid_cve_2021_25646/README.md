# Apache-druid - CVE-2021-25646

## Overview
- **Vulnerability ID**: CVE-2021-25646
- **Application**: Apache-druid
- **Port Allocation**: Port 8400
- **CLI Shortcut**: `./lab start apache-druid-cve-2021-25646`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start apache-druid-cve-2021-25646

# View container status
./lab status

# Open interactive shell inside target
./lab shell apache-druid-cve-2021-25646
```

## Verification & Exploitation
```bash
curl http://localhost:8400/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
