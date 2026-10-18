# Jenkins - CVE-2015-8103-Deser

## Overview

- **Vulnerability ID**: CVE-2015-8103
- **Application**: Jenkins
- **Port Allocation**: Port 8537
- **CLI Shortcut**: `./lab start jenkins-cve-2015-8103`

## Vulnerability Description

Jenkins unauthenticated CLI remoting port Java object deserialization remote code execution.

## Quick Start

```bash
# Start target environment
./lab start jenkins-cve-2015-8103

# View container status
./lab status

# Open interactive shell inside target
./lab shell jenkins-cve-2015-8103
```

## Verification & Exploitation

```bash
curl http://localhost:8537/
```

## Video Walkthrough

- Walkthrough: [Jenkins CVE-2015-8103-Deser Security Assessment Walkthrough](https://www.youtube.com/watch?v=IRzeBWy76NA)
