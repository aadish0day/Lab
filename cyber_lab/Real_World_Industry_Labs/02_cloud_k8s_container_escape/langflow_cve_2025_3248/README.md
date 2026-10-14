# Langflow - CVE-2025-3248

## Overview
- **Vulnerability ID**: CVE-2025-3248
- **Application**: Langflow
- **Port Allocation**: Port 8380
- **CLI Shortcut**: `./lab start langflow-cve-2025-3248`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start langflow-cve-2025-3248

# View container status
./lab status

# Open interactive shell inside target
./lab shell langflow-cve-2025-3248
```

## Verification & Exploitation
```bash
curl http://localhost:8380/
```

## Video Walkthrough
- Walkthrough: [Langflow AI Security and Prompt Injection Analysis](https://www.youtube.com/watch?v=vwbUSHUYZnc)
