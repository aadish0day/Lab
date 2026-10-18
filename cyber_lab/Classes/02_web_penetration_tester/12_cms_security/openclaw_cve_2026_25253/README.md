# Openclaw - CVE-2026-25253

## Overview

- **Vulnerability ID**: CVE-2026-25253
- **Application**: Openclaw
- **Port Allocation**: Port 8425
- **CLI Shortcut**: `./lab start openclaw-cve-2026-25253`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start openclaw-cve-2026-25253

# View container status
./lab status

# Open interactive shell inside target
./lab shell openclaw-cve-2026-25253
```

## Verification & Exploitation

```bash
curl http://localhost:8425/
```

## Video Walkthrough

- Walkthrough: [OpenClaw Gateway Security Walkthrough](https://www.youtube.com/watch?v=vwbUSHUYZnc)
