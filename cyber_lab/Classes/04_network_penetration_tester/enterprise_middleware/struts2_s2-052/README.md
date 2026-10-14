# Struts2 - S2-052

## Overview
- **Vulnerability ID**: S2-052
- **Application**: Struts2
- **Port Allocation**: Port 8325
- **CLI Shortcut**: `./lab start struts2-s2-052`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-052

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-052
```

## Verification & Exploitation
```bash
curl http://localhost:8325/
```

## Video Walkthrough
- Walkthrough: [Apache Struts 2 OGNL Exploitation Demo](https://www.youtube.com/watch?v=aOU9DbRWw2k)
