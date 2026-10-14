# Kibana - CVE-2020-7012

## Overview
- **Vulnerability ID**: CVE-2020-7012
- **Application**: Kibana
- **Port Allocation**: Port 8378
- **CLI Shortcut**: `./lab start kibana-cve-2020-7012`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start kibana-cve-2020-7012

# View container status
./lab status

# Open interactive shell inside target
./lab shell kibana-cve-2020-7012
```

## Verification & Exploitation
```bash
curl http://localhost:8378/
```

## Video Walkthrough
- Walkthrough: [Kibana Security Vulnerability and LFI Analysis](https://www.youtube.com/watch?v=YZLnfjM3cg4)
