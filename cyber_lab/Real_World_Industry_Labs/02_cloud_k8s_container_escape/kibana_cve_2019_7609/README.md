# Kibana - CVE-2019-7609

## Overview

- **Vulnerability ID**: CVE-2019-7609
- **Application**: Kibana
- **Port Allocation**: Port 8377
- **CLI Shortcut**: `./lab start kibana-cve-2019-7609`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start kibana-cve-2019-7609

# View container status
./lab status

# Open interactive shell inside target
./lab shell kibana-cve-2019-7609
```

## Verification & Exploitation

```bash
curl http://localhost:8377/
```

## Video Walkthrough

- Walkthrough: [Kibana Security Vulnerability and LFI Analysis](https://www.youtube.com/watch?v=YZLnfjM3cg4)
