# Php - FPM

## Overview

- **Vulnerability ID**: FPM
- **Application**: Php
- **Port Allocation**: Port 8293
- **CLI Shortcut**: `./lab start php-fpm`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start php-fpm

# View container status
./lab status

# Open interactive shell inside target
./lab shell php-fpm
```

## Verification & Exploitation

```bash
curl http://localhost:8293/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
