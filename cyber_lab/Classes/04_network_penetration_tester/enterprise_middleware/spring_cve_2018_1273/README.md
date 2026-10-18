# Spring - CVE-2018-1273

## Overview

- **Vulnerability ID**: CVE-2018-1273
- **Application**: Spring
- **Port Allocation**: Port 8499
- **CLI Shortcut**: `./lab start spring-cve-2018-1273`

## Vulnerability Description

Spring Data Commons property path SpEL expression injection remote code execution.

## Quick Start

```bash
# Start target environment
./lab start spring-cve-2018-1273

# View container status
./lab status

# Open interactive shell inside target
./lab shell spring-cve-2018-1273
```

## Verification & Exploitation

```bash
curl http://localhost:8499/
```

## Video Walkthrough

- Walkthrough: [Spring CVE-2018-1273 Security Assessment Walkthrough](https://www.youtube.com/watch?v=9FrsVPzqfUE)
