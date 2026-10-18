# Struts2 - S2-053

## Overview

- **Vulnerability ID**: S2-053
- **Application**: Struts2
- **Port Allocation**: Port 8326
- **CLI Shortcut**: `./lab start middleware-struts2-s2-053`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start middleware-struts2-s2-053

# View container status
./lab status

# Open interactive shell inside target
./lab shell middleware-struts2-s2-053
```

## Verification & Exploitation

```bash
curl http://localhost:8326/
```

## Video Walkthrough

- Walkthrough: [Apache Struts 2 OGNL Exploitation Demo](https://www.youtube.com/watch?v=aOU9DbRWw2k)
