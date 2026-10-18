# WebLogic - CVE-2017-10271

## Overview

- **Vulnerability ID**: CVE-2017-10271
- **Application**: WebLogic
- **Port Allocation**: Port 8507
- **CLI Shortcut**: `./lab start weblogic-cve-2017-10271`

## Vulnerability Description

Oracle WebLogic WLS-WSAT component XMLDecoder deserialization remote code execution.

## Quick Start

```bash
# Start target environment
./lab start weblogic-cve-2017-10271

# View container status
./lab status

# Open interactive shell inside target
./lab shell weblogic-cve-2017-10271
```

## Verification & Exploitation

```bash
curl http://localhost:8507/
```

## Video Walkthrough

- Walkthrough: [WebLogic CVE-2017-10271 Security Assessment Walkthrough](https://www.youtube.com/watch?v=BxDdtHBZlRc)
