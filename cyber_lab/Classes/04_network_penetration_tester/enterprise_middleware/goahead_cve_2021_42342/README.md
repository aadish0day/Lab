# Goahead - CVE-2021-42342

## Overview

- **Vulnerability ID**: CVE-2021-42342
- **Application**: Goahead
- **Port Allocation**: Port 8411
- **CLI Shortcut**: `./lab start goahead-cve-2021-42342`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start goahead-cve-2021-42342

# View container status
./lab status

# Open interactive shell inside target
./lab shell goahead-cve-2021-42342
```

## Verification & Exploitation

```bash
curl http://localhost:8411/
```

## Video Walkthrough

- Walkthrough: [GoAhead Web Server Security Walkthrough](https://www.youtube.com/watch?v=MiaEWNruYdI)
