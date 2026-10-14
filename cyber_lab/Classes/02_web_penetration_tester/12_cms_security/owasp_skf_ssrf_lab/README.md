# OWASP-SKF - SSRF-Lab

## Overview
- **Vulnerability ID**: SKF-SSRF
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8525
- **CLI Shortcut**: `./lab start owasp-skf-ssrf-lab`

## Vulnerability Description
OWASP Security Knowledge Framework Server-Side Request Forgery laboratory targeting cloud metadata.

## Quick Start
```bash
# Start target environment
./lab start owasp-skf-ssrf-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-ssrf-lab
```

## Verification & Exploitation
```bash
curl http://localhost:8525/
```

## Video Walkthrough
- Walkthrough: [OWASP-SKF SSRF-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=GLdqXN7pNrU)
