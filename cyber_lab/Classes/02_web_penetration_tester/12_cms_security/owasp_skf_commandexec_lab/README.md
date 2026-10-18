# OWASP-SKF - CommandExec-Lab

## Overview

- **Vulnerability ID**: SKF-CMDEXEC
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8532
- **CLI Shortcut**: `./lab start owasp-skf-commandexec-lab`

## Vulnerability Description

OWASP Security Knowledge Framework arbitrary command execution laboratory with shell parameter bypass.

## Quick Start

```bash
# Start target environment
./lab start owasp-skf-commandexec-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-commandexec-lab
```

## Verification & Exploitation

```bash
curl http://localhost:8532/
```

## Video Walkthrough

- Walkthrough: [OWASP-SKF CommandExec-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=Hv8H7ZgNdi4)
