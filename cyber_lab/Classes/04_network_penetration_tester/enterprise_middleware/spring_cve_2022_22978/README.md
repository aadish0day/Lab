# Spring - CVE-2022-22978

## Overview
- **Vulnerability ID**: CVE-2022-22978
- **Application**: Spring
- **Port Allocation**: Port 8503
- **CLI Shortcut**: `./lab start spring-cve-2022-22978`

## Vulnerability Description
Spring Security RegexRequestMatcher regex newline authorization bypass vulnerability.

## Quick Start
```bash
# Start target environment
./lab start spring-cve-2022-22978

# View container status
./lab status

# Open interactive shell inside target
./lab shell spring-cve-2022-22978
```

## Verification & Exploitation
```bash
curl http://localhost:8503/
```

## Video Walkthrough
- Walkthrough: [Spring CVE-2022-22978 Security Assessment Walkthrough](https://www.youtube.com/watch?v=9gwyj4frqwc)
