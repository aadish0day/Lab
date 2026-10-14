# V2Board - 1.6-privilege-escalation

## Overview
- **Vulnerability ID**: 1.6-PRIV-ESC
- **Application**: V2Board
- **Port Allocation**: Port 8462
- **CLI Shortcut**: `./lab start v2board-1-6-privilege-escalation`

## Vulnerability Description
V2Board version 1.6.1 authentication bypass and administrative privilege escalation vulnerability.

## Quick Start
```bash
# Start target environment
./lab start v2board-1-6-privilege-escalation

# View container status
./lab status

# Open interactive shell inside target
./lab shell v2board-1-6-privilege-escalation
```

## Verification & Exploitation
```bash
curl http://localhost:8462/
```

## Video Walkthrough
- Walkthrough: [V2Board 1.6-privilege-escalation Security Assessment Walkthrough](https://www.youtube.com/watch?v=-bKEWqcyEBY)
