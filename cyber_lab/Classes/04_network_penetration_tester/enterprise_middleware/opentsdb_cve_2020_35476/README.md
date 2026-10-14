# Opentsdb - CVE-2020-35476

## Overview
- **Vulnerability ID**: CVE-2020-35476
- **Application**: Opentsdb
- **Port Allocation**: Port 8456
- **CLI Shortcut**: `./lab start opentsdb-cve-2020-35476`

## Vulnerability Description
OpenTSDB is a distributed, scalable Time Series Database (TSDB) written on top of HBase.

## Quick Start
```bash
# Start target environment
./lab start opentsdb-cve-2020-35476

# View container status
./lab status

# Open interactive shell inside target
./lab shell opentsdb-cve-2020-35476
```

## Verification & Exploitation
```bash
curl http://localhost:8456/
```

## Video Walkthrough
- Walkthrough: [OpenTSDB Time Series Database Security Analysis](https://www.youtube.com/watch?v=vwbUSHUYZnc)
