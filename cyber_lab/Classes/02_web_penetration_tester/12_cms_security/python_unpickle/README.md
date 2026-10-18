# Python - UNPICKLE

## Overview

- **Vulnerability ID**: UNPICKLE
- **Application**: Python
- **Port Allocation**: Port 8436
- **CLI Shortcut**: `./lab start python-unpickle`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start python-unpickle

# View container status
./lab status

# Open interactive shell inside target
./lab shell python-unpickle
```

## Verification & Exploitation

```bash
curl http://localhost:8436/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
