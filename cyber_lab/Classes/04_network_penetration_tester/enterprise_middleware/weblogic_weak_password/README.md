# Weblogic - WEAK_PASSWORD

## Overview
- **Vulnerability ID**: WEAK_PASSWORD
- **Application**: Weblogic
- **Port Allocation**: Port 8335
- **CLI Shortcut**: `./lab start weblogic-weak_password`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start weblogic-weak_password

# View container status
./lab status

# Open interactive shell inside target
./lab shell weblogic-weak_password
```

## Verification & Exploitation
```bash
curl http://localhost:8335/
```

## Video Walkthrough
- Walkthrough: [Oracle WebLogic Server Deserialization RCE](https://www.youtube.com/watch?v=dn3DZHkcGh0)
