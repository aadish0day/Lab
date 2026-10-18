# OWASP-SKF - LFI-Lab

## Overview

- **Vulnerability ID**: SKF-LFI
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8527
- **CLI Shortcut**: `./lab start owasp-skf-lfi-lab`

## Vulnerability Description

OWASP Security Knowledge Framework Local File Inclusion laboratory testing path traversal.

## Quick Start

```bash
# Start target environment
./lab start owasp-skf-lfi-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-lfi-lab
```

## Verification & Exploitation

```bash
curl http://localhost:8527/
```

## Video Walkthrough

- Walkthrough: [OWASP-SKF LFI-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=HC8CYztjkA8)
