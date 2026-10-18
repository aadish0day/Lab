# Spring - CVE-2022-22947

## Overview

- **Vulnerability ID**: CVE-2022-22947
- **Application**: Spring
- **Port Allocation**: Port 8500
- **CLI Shortcut**: `./lab start spring-cve-2022-22947`

## Vulnerability Description

Spring Cloud Gateway actuator endpoint code injection via SpEL expression evaluation.

## Quick Start

```bash
# Start target environment
./lab start spring-cve-2022-22947

# View container status
./lab status

# Open interactive shell inside target
./lab shell spring-cve-2022-22947
```

## Verification & Exploitation

```bash
curl http://localhost:8500/
```

## Video Walkthrough

- Walkthrough: [Spring CVE-2022-22947 Security Assessment Walkthrough](https://www.youtube.com/watch?v=9N6jqM2PI1M)
