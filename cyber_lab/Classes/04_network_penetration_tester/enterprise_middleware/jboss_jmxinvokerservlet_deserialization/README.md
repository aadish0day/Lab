# Jboss - JMXINVOKERSERVLET-DESERIALIZATION

## Overview
- **Vulnerability ID**: JMXINVOKERSERVLET-DESERIALIZATION
- **Application**: Jboss
- **Port Allocation**: Port 8420
- **CLI Shortcut**: `./lab start jboss-jmxinvokerservlet-dese`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start jboss-jmxinvokerservlet-dese

# View container status
./lab status

# Open interactive shell inside target
./lab shell jboss-jmxinvokerservlet-dese
```

## Verification & Exploitation
```bash
curl http://localhost:8420/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
