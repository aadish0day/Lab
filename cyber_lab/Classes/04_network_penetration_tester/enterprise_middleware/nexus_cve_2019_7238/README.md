# Nexus - CVE-2019-7238

## Overview

- **Vulnerability ID**: CVE-2019-7238
- **Application**: Nexus
- **Port Allocation**: Port 8484
- **CLI Shortcut**: `./lab start nexus-cve-2019-7238`

## Vulnerability Description

Sonatype Nexus Repository Manager 3 unauthenticated Remote Code Execution via groovy expression injection.

## Quick Start

```bash
# Start target environment
./lab start nexus-cve-2019-7238

# View container status
./lab status

# Open interactive shell inside target
./lab shell nexus-cve-2019-7238
```

## Verification & Exploitation

```bash
curl http://localhost:8484/
```

## Video Walkthrough

- Walkthrough: [Nexus CVE-2019-7238 Security Assessment Walkthrough](https://www.youtube.com/watch?v=5cV9wh2w-O8)
