# Jboss - CVE-2017-12149

## Overview

- **Vulnerability ID**: CVE-2017-12149
- **Application**: Jboss
- **Port Allocation**: Port 8419
- **CLI Shortcut**: `./lab start jboss-cve-2017-12149`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start jboss-cve-2017-12149

# View container status
./lab status

# Open interactive shell inside target
./lab shell jboss-cve-2017-12149
```

## Verification & Exploitation

```bash
curl http://localhost:8419/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
