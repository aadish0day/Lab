# Fastjson - CVE-2017-18349

## Overview

- **Vulnerability ID**: CVE-2017-18349
- **Application**: Fastjson
- **Port Allocation**: Port 8307
- **CLI Shortcut**: `./lab start fastjson-1.2.24-rce`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start fastjson-1.2.24-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell fastjson-1.2.24-rce
```

## Verification & Exploitation

```bash
curl http://localhost:8307/
```

## Video Walkthrough

- Walkthrough: [Fastjson Deserialization Vulnerability Analysis](https://www.youtube.com/watch?v=bZGDrNmCRWo)
