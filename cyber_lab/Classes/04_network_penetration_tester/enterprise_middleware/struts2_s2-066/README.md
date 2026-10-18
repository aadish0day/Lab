# Struts2 - CVE-2023-50164

## Overview

- **Vulnerability ID**: CVE-2023-50164
- **Application**: Struts2
- **Port Allocation**: Port 8327
- **CLI Shortcut**: `./lab start middleware-struts2-s2-066`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start middleware-struts2-s2-066

# View container status
./lab status

# Open interactive shell inside target
./lab shell middleware-struts2-s2-066
```

## Verification & Exploitation

```bash
curl http://localhost:8327/
```

## Video Walkthrough

- Walkthrough: [Apache Struts 2 OGNL Exploitation Demo](https://www.youtube.com/watch?v=aOU9DbRWw2k)
