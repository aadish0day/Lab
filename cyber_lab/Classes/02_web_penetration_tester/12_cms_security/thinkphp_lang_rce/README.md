# ThinkPHP - lang-rce

## Overview
- **Vulnerability ID**: LANG-RCE
- **Application**: ThinkPHP
- **Port Allocation**: Port 8461
- **CLI Shortcut**: `./lab start thinkphp-lang-rce`

## Vulnerability Description
ThinkPHP multi-language parameter file inclusion leading to Remote Code Execution.

## Quick Start
```bash
# Start target environment
./lab start thinkphp-lang-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell thinkphp-lang-rce
```

## Verification & Exploitation
```bash
curl http://localhost:8461/
```

## Video Walkthrough
- Walkthrough: [ThinkPHP lang-rce Security Assessment Walkthrough](https://www.youtube.com/watch?v=-Xhw9zqA5xo)
