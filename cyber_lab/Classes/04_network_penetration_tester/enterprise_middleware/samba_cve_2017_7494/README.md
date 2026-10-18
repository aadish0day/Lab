# Samba - CVE-2017-7494

## Overview

- **Vulnerability ID**: CVE-2017-7494
- **Application**: Samba
- **Port Allocation**: Port 8491
- **CLI Shortcut**: `./lab start samba-cve-2017-7494`

## Vulnerability Description

Samba 'SambaCry' remote code execution vulnerability from a writable share.

## Quick Start

```bash
# Start target environment
./lab start samba-cve-2017-7494

# View container status
./lab status

# Open interactive shell inside target
./lab shell samba-cve-2017-7494
```

## Verification & Exploitation

```bash
curl http://localhost:8491/
```

## Video Walkthrough

- Walkthrough: [Samba CVE-2017-7494 Security Assessment Walkthrough](https://www.youtube.com/watch?v=7jXCBgmOG-M)
