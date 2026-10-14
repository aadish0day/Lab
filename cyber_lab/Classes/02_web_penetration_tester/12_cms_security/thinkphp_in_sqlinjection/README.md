# ThinkPHP - in-sqlinjection

## Overview
- **Vulnerability ID**: IN-SQLI
- **Application**: ThinkPHP
- **Port Allocation**: Port 8460
- **CLI Shortcut**: `./lab start thinkphp-in-sqlinjection`

## Vulnerability Description
ThinkPHP framework SQL injection vulnerability caused by insufficient sanitization of query parameters.

## Quick Start
```bash
# Start target environment
./lab start thinkphp-in-sqlinjection

# View container status
./lab status

# Open interactive shell inside target
./lab shell thinkphp-in-sqlinjection
```

## Verification & Exploitation
```bash
curl http://localhost:8460/
```

## Video Walkthrough
- Walkthrough: [ThinkPHP in-sqlinjection Security Assessment Walkthrough](https://www.youtube.com/watch?v=-Cy4u6fA3Os)
