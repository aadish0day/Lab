# Fastjson - 1.2.47-RCE

## Overview

- **Vulnerability ID**: 1.2.47-RCE
- **Application**: Fastjson
- **Port Allocation**: Port 8308
- **CLI Shortcut**: `./lab start fastjson-1.2.47-rce`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start fastjson-1.2.47-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell fastjson-1.2.47-rce
```

## Verification & Exploitation

```bash
curl http://localhost:8308/
```

## Video Walkthrough

- Walkthrough: [Fastjson Deserialization Vulnerability Analysis](https://www.youtube.com/watch?v=bZGDrNmCRWo)
