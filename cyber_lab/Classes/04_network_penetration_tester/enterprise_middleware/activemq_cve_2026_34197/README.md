# Activemq - CVE-2026-34197

## Overview
- **Vulnerability ID**: CVE-2026-34197
- **Application**: Activemq
- **Port Allocation**: Port 8398
- **CLI Shortcut**: `./lab start activemq-cve-2026-34197`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start activemq-cve-2026-34197

# View container status
./lab status

# Open interactive shell inside target
./lab shell activemq-cve-2026-34197
```

## Verification & Exploitation
```bash
curl http://localhost:8398/
```

## Video Walkthrough
- Walkthrough: [ActiveMQ Security Walkthrough](https://www.youtube.com/watch?v=1OvVwZgqnlo)
