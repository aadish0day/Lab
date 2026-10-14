# OWASP-SKF - JWT-Lab

## Overview
- **Vulnerability ID**: SKF-JWT
- **Application**: OWASP-SKF
- **Port Allocation**: Port 8533
- **CLI Shortcut**: `./lab start owasp-skf-jwt-lab`

## Vulnerability Description
OWASP Security Knowledge Framework JSON Web Token signature verification and 'none' algorithm bypass.

## Quick Start
```bash
# Start target environment
./lab start owasp-skf-jwt-lab

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-skf-jwt-lab
```

## Verification & Exploitation
```bash
curl http://localhost:8533/
```

## Video Walkthrough
- Walkthrough: [OWASP-SKF JWT-Lab Security Assessment Walkthrough](https://www.youtube.com/watch?v=Hx0rqVlsVv0)
