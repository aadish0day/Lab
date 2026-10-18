# Kafka - CVE-2023-25194

## Overview

- **Vulnerability ID**: CVE-2023-25194
- **Application**: Kafka
- **Port Allocation**: Port 8375
- **CLI Shortcut**: `./lab start kafka-cve-2023-25194`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start kafka-cve-2023-25194

# View container status
./lab status

# Open interactive shell inside target
./lab shell kafka-cve-2023-25194
```

## Verification & Exploitation

```bash
curl http://localhost:8375/
```

## Video Walkthrough

- Walkthrough: [Apache Kafka Security Analysis](https://www.youtube.com/watch?v=Las8buvwEUk)
