# Opentsdb - CVE-2023-25826

## Overview

- **Vulnerability ID**: CVE-2023-25826
- **Application**: Opentsdb
- **Port Allocation**: Port 8457
- **CLI Shortcut**: `./lab start opentsdb-cve-2023-25826`

## Vulnerability Description

OpenTSDB is a distributed, scalable Time Series Database (TSDB) written on top of HBase.
In version 2.4.1 and earlier, there is a command injection vulnerability. This vulnerability is actually due to an incomplete fix for CVE-2020-35476, so the entire reproduction process is similar to the previous one.

## Quick Start

```bash
# Start target environment
./lab start opentsdb-cve-2023-25826

# View container status
./lab status

# Open interactive shell inside target
./lab shell opentsdb-cve-2023-25826
```

## Verification & Exploitation

```bash
curl http://localhost:8457/
```

## Video Walkthrough

- Walkthrough: [OpenTSDB Time Series Database Security Analysis](https://www.youtube.com/watch?v=vwbUSHUYZnc)
