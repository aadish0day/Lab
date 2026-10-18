# Gitea - 1.4-RCE

## Overview

- **Vulnerability ID**: 1.4-RCE
- **Application**: Gitea
- **Port Allocation**: Port 8359
- **CLI Shortcut**: `./lab start gitea-1.4-rce`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start gitea-1.4-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell gitea-1.4-rce
```

## Verification & Exploitation

```bash
curl http://localhost:8359/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
