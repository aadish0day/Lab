# OWASP-SKF - SQLi-Lab

## Overview

- **Vulnerability ID**: SKF-SQLI
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8524
- **CLI Shortcut**: `./lab start owasp-skf-sqli-lab`

## Vulnerability Description

OWASP Security Knowledge Framework SQL Injection practical lab testing UNION and error-based attacks.

## Quick Start

```bash
# Start target environment
./lab start owasp-skf-sqli-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-sqli-lab
```

## Verification & Exploitation

```bash
curl http://localhost:8524/
```

## Video Walkthrough

- Walkthrough: [OWASP-SKF SQLi-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=FvvdxA11-ZU)
