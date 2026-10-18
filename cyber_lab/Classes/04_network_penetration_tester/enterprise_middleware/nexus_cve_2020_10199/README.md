# Nexus - CVE-2020-10199

## Overview

- **Vulnerability ID**: CVE-2020-10199
- **Application**: Nexus
- **Port Allocation**: Port 8485
- **CLI Shortcut**: `./lab start nexus-cve-2020-10199`

## Vulnerability Description

Sonatype Nexus Repository Manager 3 authenticated Remote Code Execution via JEXL syntax evaluation.

## Quick Start

```bash
# Start target environment
./lab start nexus-cve-2020-10199

# View container status
./lab status

# Open interactive shell inside target
./lab shell nexus-cve-2020-10199
```

## Verification & Exploitation

```bash
curl http://localhost:8485/
```

## Video Walkthrough

- Walkthrough: [Nexus CVE-2020-10199 Security Assessment Walkthrough](https://www.youtube.com/watch?v=5nk1a1Jl_jk)
