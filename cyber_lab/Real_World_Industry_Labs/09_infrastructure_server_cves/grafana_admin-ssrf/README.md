# Grafana - ADMIN-SSRF

## Overview
- **Vulnerability ID**: ADMIN-SSRF
- **Application**: Grafana
- **Port Allocation**: Port 8364
- **CLI Shortcut**: `./lab start grafana-admin-ssrf`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start grafana-admin-ssrf

# View container status
./lab status

# Open interactive shell inside target
./lab shell grafana-admin-ssrf
```

## Verification & Exploitation
```bash
curl http://localhost:8364/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
