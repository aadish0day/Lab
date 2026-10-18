# OWASP-SKF - CSRF-Lab

## Overview

- **Vulnerability ID**: SKF-CSRF
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8530
- **CLI Shortcut**: `./lab start owasp-skf-csrf-lab`

## Vulnerability Description

OWASP Security Knowledge Framework Cross-Site Request Forgery practical exploitation environment.

## Quick Start

```bash
# Start target environment
./lab start owasp-skf-csrf-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-csrf-lab
```

## Verification & Exploitation

```bash
curl http://localhost:8530/
```

## Video Walkthrough

- Walkthrough: [OWASP-SKF CSRF-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=HRRTrnRgMjs)
