# Log4j - CVE-2017-5645

## Overview

- **Vulnerability ID**: CVE-2017-5645
- **Application**: Log4j
- **Port Allocation**: Port 8384
- **CLI Shortcut**: `./lab start log4j-cve-2017-5645`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start log4j-cve-2017-5645

# View container status
./lab status

# Open interactive shell inside target
./lab shell log4j-cve-2017-5645
```

## Verification & Exploitation

```bash
curl http://localhost:8384/
```

## Video Walkthrough

- Walkthrough: [Apache Log4j Security Walkthrough](https://www.youtube.com/watch?v=K7n2Bi_6wM4)
