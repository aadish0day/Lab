# Pgadmin - CVE-2022-4223

## Overview

- **Vulnerability ID**: CVE-2022-4223
- **Application**: Pgadmin
- **Port Allocation**: Port 8458
- **CLI Shortcut**: `./lab start pgadmin-cve-2022-4223`

## Vulnerability Description

pgAdmin is a popular and feature rich Open Source administration and development platform for PostgreSQL, the most advanced Open Source database in the world.

## Quick Start

```bash
# Start target environment
./lab start pgadmin-cve-2022-4223

# View container status
./lab status

# Open interactive shell inside target
./lab shell pgadmin-cve-2022-4223
```

## Verification & Exploitation

```bash
curl http://localhost:8458/
```

## Video Walkthrough

- Walkthrough: [pgAdmin PostgreSQL Web Management Security Walkthrough](https://www.youtube.com/watch?v=vmSTJI3gFSg)
