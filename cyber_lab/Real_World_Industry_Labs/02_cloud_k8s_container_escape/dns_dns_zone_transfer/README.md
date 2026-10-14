# Dns - DNS-ZONE-TRANSFER

## Overview
- **Vulnerability ID**: DNS-ZONE-TRANSFER
- **Application**: Dns
- **Port Allocation**: Port 8392
- **CLI Shortcut**: `./lab start dns-dns-zone-transfer`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start dns-dns-zone-transfer

# View container status
./lab status

# Open interactive shell inside target
./lab shell dns-dns-zone-transfer
```

## Verification & Exploitation
```bash
curl http://localhost:8392/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
