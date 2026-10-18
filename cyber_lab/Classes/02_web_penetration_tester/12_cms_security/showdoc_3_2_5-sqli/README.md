# Showdoc - 3.2.5-SQLI

## Overview

- **Vulnerability ID**: 3.2.5-SQLI
- **Application**: Showdoc
- **Port Allocation**: Port 8300
- **CLI Shortcut**: `./lab start showdoc-3.2.5-sqli`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start showdoc-3.2.5-sqli

# View container status
./lab status

# Open interactive shell inside target
./lab shell showdoc-3.2.5-sqli
```

## Verification & Exploitation

```bash
curl http://localhost:8300/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
