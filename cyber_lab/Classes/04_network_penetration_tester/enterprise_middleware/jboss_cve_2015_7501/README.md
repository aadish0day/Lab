# JBoss - CVE-2015-7501-Deser

## Overview

- **Vulnerability ID**: CVE-2015-7501
- **Application**: JBoss
- **Port Allocation**: Port 8538
- **CLI Shortcut**: `./lab start jboss-cve-2015-7501`

## Vulnerability Description

JBoss Application Server JMXInvokerServlet unauthenticated Java deserialization remote code execution.

## Quick Start

```bash
# Start target environment
./lab start jboss-cve-2015-7501

# View container status
./lab status

# Open interactive shell inside target
./lab shell jboss-cve-2015-7501
```

## Verification & Exploitation

```bash
curl http://localhost:8538/
```

## Video Walkthrough

- Walkthrough: [JBoss CVE-2015-7501-Deser Security Assessment Walkthrough](https://www.youtube.com/watch?v=IbqjtqTeyr0)
