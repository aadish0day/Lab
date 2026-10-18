# Struts2 - S2-devMode

## Overview

- **Vulnerability ID**: S2-DEVMODE
- **Application**: Struts2
- **Port Allocation**: Port 8553
- **CLI Shortcut**: `./lab start middleware-struts2-s2-devmode`

## Vulnerability Description

Apache Struts 2 development mode debug interceptor enabled remote command execution.

## Quick Start

```bash
# Start target environment
./lab start middleware-struts2-s2-devmode

# View container status
./lab status

# Open interactive shell inside target
./lab shell middleware-struts2-s2-devmode
```

## Verification & Exploitation

```bash
curl http://localhost:8553/
```

## Video Walkthrough

- Walkthrough: [Struts2 S2-devMode Security Assessment Walkthrough](https://www.youtube.com/watch?v=LBkuZa6niR0)
