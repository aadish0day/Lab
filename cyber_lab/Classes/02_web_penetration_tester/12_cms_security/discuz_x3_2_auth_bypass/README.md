# Discuz - X3.2-Auth-Bypass

## Overview
- **Vulnerability ID**: DISCUZ-X32-AUTH
- **Application**: Discuz
- **Port Allocation**: Port 8516
- **CLI Shortcut**: `./lab start discuz-x3-2-auth-bypass`

## Vulnerability Description
Discuz! X3.2 forum software administrative authentication bypass and database disclosure vulnerability.

## Quick Start
```bash
# Start target environment
./lab start discuz-x3-2-auth-bypass

# View container status
./lab status

# Open interactive shell inside target
./lab shell discuz-x3-2-auth-bypass
```

## Verification & Exploitation
```bash
curl http://localhost:8516/
```

## Video Walkthrough
- Walkthrough: [Discuz X3.2-Auth-Bypass Security Assessment Walkthrough](https://www.youtube.com/watch?v=ErWhWBdDwTU)
