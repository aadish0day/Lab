# Elasticsearch - CVE-2014-3120

## Overview
- **Vulnerability ID**: CVE-2014-3120
- **Application**: Elasticsearch
- **Port Allocation**: Port 8393
- **CLI Shortcut**: `./lab start elasticsearch-cve-2014-3120`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start elasticsearch-cve-2014-3120

# View container status
./lab status

# Open interactive shell inside target
./lab shell elasticsearch-cve-2014-3120
```

## Verification & Exploitation
```bash
curl http://localhost:8393/
```

## Video Walkthrough
- Walkthrough: [Elasticsearch Security and Query Injection](https://www.youtube.com/watch?v=ptajUIqk_Ao)
