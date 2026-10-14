# OWASP-SKF - CORS-Lab

## Overview
- **Vulnerability ID**: SKF-CORS
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8529
- **CLI Shortcut**: `./lab start owasp-skf-cors-lab`

## Vulnerability Description
OWASP Security Knowledge Framework Cross-Origin Resource Sharing misconfiguration laboratory.

## Quick Start
```bash
# Start target environment
./lab start owasp-skf-cors-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-cors-lab
```

## Verification & Exploitation
```bash
curl http://localhost:8529/
```

## Video Walkthrough
- Walkthrough: [OWASP-SKF CORS-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=HM3Z-I998b4)
