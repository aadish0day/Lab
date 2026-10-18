# Spring - CVE-2022-22963

## Overview

- **Vulnerability ID**: CVE-2022-22963
- **Application**: Spring
- **Port Allocation**: Port 8501
- **CLI Shortcut**: `./lab start spring-cve-2022-22963`

## Vulnerability Description

Spring Cloud Function routing expression SpEL injection remote code execution.

## Quick Start

```bash
# Start target environment
./lab start spring-cve-2022-22963

# View container status
./lab status

# Open interactive shell inside target
./lab shell spring-cve-2022-22963
```

## Verification & Exploitation

```bash
curl http://localhost:8501/
```

## Video Walkthrough

- Walkthrough: [Spring CVE-2022-22963 Security Assessment Walkthrough](https://www.youtube.com/watch?v=9P8N4LOqquw)
