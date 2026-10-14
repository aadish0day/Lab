# OWASP-SKF - IDOR-Lab

## Overview
- **Vulnerability ID**: SKF-IDOR
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8526
- **CLI Shortcut**: `./lab start owasp-skf-idor-lab`

## Vulnerability Description
OWASP Security Knowledge Framework Insecure Direct Object References practical assessment lab.

## Quick Start
```bash
# Start target environment
./lab start owasp-skf-idor-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-idor-lab
```

## Verification & Exploitation
```bash
curl http://localhost:8526/
```

## Video Walkthrough
- Walkthrough: [OWASP-SKF IDOR-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=Gk3_Q-3R6jc)
