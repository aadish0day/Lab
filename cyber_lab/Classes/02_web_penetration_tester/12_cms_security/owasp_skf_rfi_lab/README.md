# OWASP-SKF - RFI-Lab

## Overview
- **Vulnerability ID**: SKF-RFI
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8528
- **CLI Shortcut**: `./lab start owasp-skf-rfi-lab`

## Vulnerability Description
OWASP Security Knowledge Framework Remote File Inclusion laboratory demonstrating remote code injection.

## Quick Start
```bash
# Start target environment
./lab start owasp-skf-rfi-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-rfi-lab
```

## Verification & Exploitation
```bash
curl http://localhost:8528/
```

## Video Walkthrough
- Walkthrough: [OWASP-SKF RFI-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=HKXA3Ydrcus)
