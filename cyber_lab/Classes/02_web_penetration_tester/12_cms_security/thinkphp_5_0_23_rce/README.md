# ThinkPHP - 5.0.23-RCE

## Overview

- **Vulnerability ID**: 5.0.23-RCE
- **Application**: ThinkPHP
- **Port Allocation**: Port 8459
- **CLI Shortcut**: `./lab start thinkphp-5-0-23-rce`

## Vulnerability Description

ThinkPHP 5.0.23 Remote Code Execution vulnerability in method parameter filtering.

## Quick Start

```bash
# Start target environment
./lab start thinkphp-5-0-23-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell thinkphp-5-0-23-rce
```

## Verification & Exploitation

```bash
curl http://localhost:8459/
```

## Video Walkthrough

- Walkthrough: [ThinkPHP 5.0.23-RCE Security Assessment Walkthrough](https://www.youtube.com/watch?v=-2_EUSTcfx4)
