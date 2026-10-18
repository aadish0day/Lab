# Elasticsearch - CVE-2015-5531

## Overview

- **Vulnerability ID**: CVE-2015-5531
- **Application**: Elasticsearch
- **Port Allocation**: Port 8352
- **CLI Shortcut**: `./lab start elasticsearch-wooyun-2015-11`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start elasticsearch-wooyun-2015-11

# View container status
./lab status

# Open interactive shell inside target
./lab shell elasticsearch-wooyun-2015-11
```

## Verification & Exploitation

```bash
curl http://localhost:8352/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
