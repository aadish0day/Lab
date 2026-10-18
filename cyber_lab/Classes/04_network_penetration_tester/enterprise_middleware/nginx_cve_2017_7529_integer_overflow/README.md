# Nginx - CVE-2017-7529-Integer-Overflow

## Overview

- **Vulnerability ID**: CVE-2017-7529
- **Application**: Nginx
- **Port Allocation**: Port 8555
- **CLI Shortcut**: `./lab start nginx-cve-2017-7529-integer-overflow`

## Vulnerability Description

Nginx range filter module integer overflow vulnerability resulting in cache disclosure.

## Quick Start

```bash
# Start target environment
./lab start nginx-cve-2017-7529-integer-overflow

# View container status
./lab status

# Open interactive shell inside target
./lab shell nginx-cve-2017-7529-integer-overflow
```

## Verification & Exploitation

```bash
curl http://localhost:8555/
```

## Video Walkthrough

- Walkthrough: [Nginx CVE-2017-7529-Integer-Overflow Security Assessment Walkthrough](https://www.youtube.com/watch?v=Las8buvwEUk)
