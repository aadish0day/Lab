# OWASP-SKF - XSS-Lab

## Overview
- **Vulnerability ID**: SKF-XSS
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8523
- **CLI Shortcut**: `./lab start owasp-skf-xss-lab`

## Vulnerability Description
OWASP Security Knowledge Framework Cross-Site Scripting laboratory with reflected and DOM contexts.

## Quick Start
```bash
# Start target environment
./lab start owasp-skf-xss-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-xss-lab
```

## Verification & Exploitation
```bash
curl http://localhost:8523/
```

## Video Walkthrough
- Walkthrough: [OWASP-SKF XSS-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=FhORuceZ45o)
