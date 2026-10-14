# Langflow - CVE-2026-33017

## Overview
- **Vulnerability ID**: CVE-2026-33017
- **Application**: Langflow
- **Port Allocation**: Port 8381
- **CLI Shortcut**: `./lab start langflow-cve-2026-33017`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start langflow-cve-2026-33017

# View container status
./lab status

# Open interactive shell inside target
./lab shell langflow-cve-2026-33017
```

## Verification & Exploitation
```bash
curl http://localhost:8381/
```

## Video Walkthrough
- Walkthrough: [Langflow AI Security and Prompt Injection Analysis](https://www.youtube.com/watch?v=vwbUSHUYZnc)
