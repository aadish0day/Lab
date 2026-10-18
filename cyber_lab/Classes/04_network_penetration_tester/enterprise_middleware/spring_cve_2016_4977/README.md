# Spring - CVE-2016-4977

## Overview

- **Vulnerability ID**: CVE-2016-4977
- **Application**: Spring
- **Port Allocation**: Port 8495
- **CLI Shortcut**: `./lab start spring-cve-2016-4977`

## Vulnerability Description

Spring Security OAuth2 SpEL expression injection remote code execution vulnerability.

## Quick Start

```bash
# Start target environment
./lab start spring-cve-2016-4977

# View container status
./lab status

# Open interactive shell inside target
./lab shell spring-cve-2016-4977
```

## Verification & Exploitation

```bash
curl http://localhost:8495/
```

## Video Walkthrough

- Walkthrough: [Spring CVE-2016-4977 Security Assessment Walkthrough](https://www.youtube.com/watch?v=8QzOC8HfOqU)
