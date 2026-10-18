# Activemq - CVE-2016-3088

## Overview

- **Vulnerability ID**: CVE-2016-3088
- **Application**: Activemq
- **Port Allocation**: Port 8397
- **CLI Shortcut**: `./lab start activemq-cve-2016-3088`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start activemq-cve-2016-3088

# View container status
./lab status

# Open interactive shell inside target
./lab shell activemq-cve-2016-3088
```

## Verification & Exploitation

```bash
curl http://localhost:8397/
```

## Video Walkthrough

- Walkthrough: [ActiveMQ Security Walkthrough](https://www.youtube.com/watch?v=1OvVwZgqnlo)
