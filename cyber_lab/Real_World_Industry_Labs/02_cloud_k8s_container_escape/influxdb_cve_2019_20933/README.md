# Influxdb - CVE-2019-20933

## Overview

- **Vulnerability ID**: CVE-2019-20933
- **Application**: Influxdb
- **Port Allocation**: Port 8372
- **CLI Shortcut**: `./lab start influxdb-cve-2019-20933`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start influxdb-cve-2019-20933

# View container status
./lab status

# Open interactive shell inside target
./lab shell influxdb-cve-2019-20933
```

## Verification & Exploitation

```bash
curl http://localhost:8372/
```

## Video Walkthrough

- Walkthrough: [InfluxDB Security Analysis and Auth Bypass](https://www.youtube.com/watch?v=vwbUSHUYZnc)
