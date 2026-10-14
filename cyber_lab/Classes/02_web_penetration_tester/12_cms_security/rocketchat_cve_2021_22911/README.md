# Rocketchat - CVE-2021-22911

## Overview
- **Vulnerability ID**: CVE-2021-22911
- **Application**: Rocketchat
- **Port Allocation**: Port 8438
- **CLI Shortcut**: `./lab start rocketchat-cve-2021-22911`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start rocketchat-cve-2021-22911

# View container status
./lab status

# Open interactive shell inside target
./lab shell rocketchat-cve-2021-22911
```

## Verification & Exploitation
```bash
curl http://localhost:8438/
```

## Video Walkthrough
- Walkthrough: [Rocket.Chat Server Security Walkthrough](https://www.youtube.com/watch?v=K7n2Bi_6wM4)
