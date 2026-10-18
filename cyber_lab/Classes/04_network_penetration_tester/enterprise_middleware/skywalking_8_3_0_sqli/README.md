# SkyWalking - 8.3.0-sqli

## Overview

- **Vulnerability ID**: 8.3.0-SQLI
- **Application**: SkyWalking
- **Port Allocation**: Port 8492
- **CLI Shortcut**: `./lab start skywalking-8-3-0-sqli`

## Vulnerability Description

Apache SkyWalking APM GraphQL endpoint unauthenticated SQL injection vulnerability.

## Quick Start

```bash
# Start target environment
./lab start skywalking-8-3-0-sqli

# View container status
./lab status

# Open interactive shell inside target
./lab shell skywalking-8-3-0-sqli
```

## Verification & Exploitation

```bash
curl http://localhost:8492/
```

## Video Walkthrough

- Walkthrough: [SkyWalking 8.3.0-sqli Security Assessment Walkthrough](https://www.youtube.com/watch?v=7qoPDq41xhQ)
