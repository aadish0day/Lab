# Spring - CVE-2017-8046

## Overview

- **Vulnerability ID**: CVE-2017-8046
- **Application**: Spring
- **Port Allocation**: Port 8497
- **CLI Shortcut**: `./lab start spring-cve-2017-8046`

## Vulnerability Description

Spring Data REST PATCH request JSON Patch SpEL expression injection RCE.

## Quick Start

```bash
# Start target environment
./lab start spring-cve-2017-8046

# View container status
./lab status

# Open interactive shell inside target
./lab shell spring-cve-2017-8046
```

## Verification & Exploitation

```bash
curl http://localhost:8497/
```

## Video Walkthrough

- Walkthrough: [Spring CVE-2017-8046 Security Assessment Walkthrough](https://www.youtube.com/watch?v=96UzSrie_r8)
