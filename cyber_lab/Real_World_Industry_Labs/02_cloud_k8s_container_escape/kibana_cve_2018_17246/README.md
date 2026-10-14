# Kibana - CVE-2018-17246

## Overview
- **Vulnerability ID**: CVE-2018-17246
- **Application**: Kibana
- **Port Allocation**: Port 8376
- **CLI Shortcut**: `./lab start kibana-cve-2018-17246`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start kibana-cve-2018-17246

# View container status
./lab status

# Open interactive shell inside target
./lab shell kibana-cve-2018-17246
```

## Verification & Exploitation
```bash
curl http://localhost:8376/
```

## Video Walkthrough
- Walkthrough: [Kibana Security Vulnerability and LFI Analysis](https://www.youtube.com/watch?v=YZLnfjM3cg4)
