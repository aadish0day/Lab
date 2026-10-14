# Weblogic - SSRF

## Overview
- **Vulnerability ID**: SSRF
- **Application**: Weblogic
- **Port Allocation**: Port 8334
- **CLI Shortcut**: `./lab start weblogic-ssrf`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start weblogic-ssrf

# View container status
./lab status

# Open interactive shell inside target
./lab shell weblogic-ssrf
```

## Verification & Exploitation
```bash
curl http://localhost:8334/
```

## Video Walkthrough
- Walkthrough: [Oracle WebLogic Server Deserialization RCE](https://www.youtube.com/watch?v=dn3DZHkcGh0)
