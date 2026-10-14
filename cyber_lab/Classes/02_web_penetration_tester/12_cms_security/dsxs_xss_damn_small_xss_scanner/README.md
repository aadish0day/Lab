# DSXS-XSS - Damn-Small-XSS-Scanner

## Overview
- **Vulnerability ID**: DSXS-LAB
- **Application**: DSXS-XSS
- **Port Allocation**: Port 8522
- **CLI Shortcut**: `./lab start dsxs-xss-damn-small-xss-scanner`

## Vulnerability Description
Damn Small XSS Scanner target application providing varied XSS injection vectors and contexts.

## Quick Start
```bash
# Start target environment
./lab start dsxs-xss-damn-small-xss-scanner

# View container status
./lab status

# Open interactive shell inside target
./lab shell dsxs-xss-damn-small-xss-scanner
```

## Verification & Exploitation
```bash
curl http://localhost:8522/
```

## Video Walkthrough
- Walkthrough: [DSXS-XSS Damn-Small-XSS-Scanner Security Assessment Walkthrough](https://www.youtube.com/watch?v=FUODIae2d98)
