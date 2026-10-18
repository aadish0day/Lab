# Couchdb - CVE-2017-12636

## Overview

- **Vulnerability ID**: CVE-2017-12636
- **Application**: Couchdb
- **Port Allocation**: Port 8389
- **CLI Shortcut**: `./lab start couchdb-cve-2017-12636`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start couchdb-cve-2017-12636

# View container status
./lab status

# Open interactive shell inside target
./lab shell couchdb-cve-2017-12636
```

## Verification & Exploitation

```bash
curl http://localhost:8389/
```

## Video Walkthrough

- Walkthrough: [CouchDB Administration & Exploitation](https://www.youtube.com/watch?v=M4csb7eQrf8)
