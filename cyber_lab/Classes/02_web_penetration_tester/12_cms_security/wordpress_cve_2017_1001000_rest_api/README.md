# WordPress - CVE-2017-1001000-REST-API

## Overview

- **Vulnerability ID**: CVE-2017-1001000
- **Application**: WordPress
- **Port Allocation**: Port 8510
- **CLI Shortcut**: `./lab start wordpress-cve-2017-1001000-rest-api`

## Vulnerability Description

WordPress 4.7.0 / 4.7.1 unauthenticated content injection and defacement via REST API post update endpoint.

## Quick Start

```bash
# Start target environment
./lab start wordpress-cve-2017-1001000-rest-api

# View container status
./lab status

# Open interactive shell inside target
./lab shell wordpress-cve-2017-1001000-rest-api
```

## Verification & Exploitation

```bash
curl http://localhost:8510/
```

## Video Walkthrough

- Walkthrough: [WordPress CVE-2017-1001000-REST-API Security Assessment Walkthrough](https://www.youtube.com/watch?v=DYu8u6N4QNM)
