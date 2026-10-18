# OWASP-SKF - RaceCondition-Lab

## Overview

- **Vulnerability ID**: SKF-RACECOND
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8531
- **CLI Shortcut**: `./lab start owasp-skf-racecondition-lab`

## Vulnerability Description

OWASP Security Knowledge Framework multi-threaded limit-overrun race condition vulnerability lab.

## Quick Start

```bash
# Start target environment
./lab start owasp-skf-racecondition-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-racecondition-lab
```

## Verification & Exploitation

```bash
curl http://localhost:8531/
```

## Video Walkthrough

- Walkthrough: [OWASP-SKF RaceCondition-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=HtdGLZOuXXA)
