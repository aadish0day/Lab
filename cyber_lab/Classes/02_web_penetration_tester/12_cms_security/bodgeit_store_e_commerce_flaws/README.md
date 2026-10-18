# BodgeIt-Store - E-Commerce-Flaws

## Overview

- **Vulnerability ID**: BODGEIT-STORE
- **Application**: BodgeIt-Store
- **Port Allocation**: Port 8479
- **CLI Shortcut**: `./lab start bodgeit-store-e-commerce-flaws`

## Vulnerability Description

OWASP BodgeIt Store vulnerable e-commerce application highlighting business logic and XSS flaws.

## Quick Start

```bash
# Start target environment
./lab start bodgeit-store-e-commerce-flaws

# View container status
./lab status

# Open interactive shell inside target
./lab shell bodgeit-store-e-commerce-flaws
```

## Verification & Exploitation

```bash
curl http://localhost:8479/
```

## Video Walkthrough

- Walkthrough: [BodgeIt-Store E-Commerce-Flaws Security Assessment Walkthrough](https://www.youtube.com/watch?v=4Mm3BCyHtDY)
