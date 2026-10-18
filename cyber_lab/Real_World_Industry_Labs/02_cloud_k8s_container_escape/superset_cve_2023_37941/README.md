# Superset - CVE-2023-37941

## Overview

- **Vulnerability ID**: CVE-2023-37941
- **Application**: Superset
- **Port Allocation**: Port 8476
- **CLI Shortcut**: `./lab start superset-cve-2023-37941`

## Vulnerability Description

Apache Superset remote code execution via unsafe database engine spec parameter evaluation.

## Quick Start

```bash
# Start target environment
./lab start superset-cve-2023-37941

# View container status
./lab status

# Open interactive shell inside target
./lab shell superset-cve-2023-37941
```

## Verification & Exploitation

```bash
curl http://localhost:8476/
```

## Video Walkthrough

- Walkthrough: [Superset CVE-2023-37941 Security Assessment Walkthrough](https://www.youtube.com/watch?v=3G0MxPNl2ek)
