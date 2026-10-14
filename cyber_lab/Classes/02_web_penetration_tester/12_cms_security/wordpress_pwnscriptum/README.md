# WordPress - PwnScriptum

## Overview
- **Vulnerability ID**: PWNSCRIPTUM
- **Application**: WordPress
- **Port Allocation**: Port 8468
- **CLI Shortcut**: `./lab start wordpress-pwnscriptum`

## Vulnerability Description
WordPress 4.6 PHPMailer Host header injection vulnerability leading to arbitrary code execution.

## Quick Start
```bash
# Start target environment
./lab start wordpress-pwnscriptum

# View container status
./lab status

# Open interactive shell inside target
./lab shell wordpress-pwnscriptum
```

## Verification & Exploitation
```bash
curl http://localhost:8468/
```

## Video Walkthrough
- Walkthrough: [WordPress PwnScriptum Security Assessment Walkthrough](https://www.youtube.com/watch?v=0tyerVP9R98)
