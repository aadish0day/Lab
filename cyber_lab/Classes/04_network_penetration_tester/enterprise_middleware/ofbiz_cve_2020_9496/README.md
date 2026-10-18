# Ofbiz - CVE-2020-9496

## Overview

- **Vulnerability ID**: CVE-2020-9496
- **Application**: Ofbiz
- **Port Allocation**: Port 8451
- **CLI Shortcut**: `./lab start ofbiz-cve-2020-9496`

## Vulnerability Description

Apache OFBiz is an open source enterprise resource planning (ERP) system. It provides a suite of enterprise applications that integrate and automate many of the business processes of an enterprise.

## Quick Start

```bash
# Start target environment
./lab start ofbiz-cve-2020-9496

# View container status
./lab status

# Open interactive shell inside target
./lab shell ofbiz-cve-2020-9496
```

## Verification & Exploitation

```bash
curl http://localhost:8451/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
