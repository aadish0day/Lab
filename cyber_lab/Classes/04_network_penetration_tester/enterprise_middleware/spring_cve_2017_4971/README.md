# Spring - CVE-2017-4971

## Overview

- **Vulnerability ID**: CVE-2017-4971
- **Application**: Spring
- **Port Allocation**: Port 8496
- **CLI Shortcut**: `./lab start spring-cve-2017-4971`

## Vulnerability Description

Spring Web Flow data binding SpEL expression injection vulnerability.

## Quick Start

```bash
# Start target environment
./lab start spring-cve-2017-4971

# View container status
./lab status

# Open interactive shell inside target
./lab shell spring-cve-2017-4971
```

## Verification & Exploitation

```bash
curl http://localhost:8496/
```

## Video Walkthrough

- Walkthrough: [Spring CVE-2017-4971 Security Assessment Walkthrough](https://www.youtube.com/watch?v=91nyrDYtmyE)
