# Celery - CELERY3_REDIS_UNAUTH

## Overview

- **Vulnerability ID**: CELERY3_REDIS_UNAUTH
- **Application**: Celery
- **Port Allocation**: Port 8346
- **CLI Shortcut**: `./lab start celery-celery3_redis_unauth`

## Vulnerability Description

[中文版本(Chinese version)](./README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start celery-celery3_redis_unauth

# View container status
./lab status

# Open interactive shell inside target
./lab shell celery-celery3_redis_unauth
```

## Verification & Exploitation

```bash
curl http://localhost:8346/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
