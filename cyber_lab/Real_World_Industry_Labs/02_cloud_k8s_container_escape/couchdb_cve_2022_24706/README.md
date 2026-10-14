# Couchdb - CVE-2022-24706

## Overview
- **Vulnerability ID**: CVE-2022-24706
- **Application**: Couchdb
- **Port Allocation**: Port 8390
- **CLI Shortcut**: `./lab start couchdb-cve-2022-24706`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start couchdb-cve-2022-24706

# View container status
./lab status

# Open interactive shell inside target
./lab shell couchdb-cve-2022-24706
```

## Verification & Exploitation
```bash
curl http://localhost:8390/
```

## Video Walkthrough
- Walkthrough: [CouchDB Administration & Exploitation](https://www.youtube.com/watch?v=M4csb7eQrf8)
