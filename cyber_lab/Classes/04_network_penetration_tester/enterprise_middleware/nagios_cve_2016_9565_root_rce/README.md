# Nagios - CVE-2016-9565-Root-RCE

## Overview
- **Vulnerability ID**: CVE-2016-9565
- **Application**: Nagios
- **Port Allocation**: Port 8556
- **CLI Shortcut**: `./lab start nagios-cve-2016-9565-root-rce`

## Vulnerability Description
Nagios Core unauthenticated HTTP header command injection leading to root privilege code execution.

## Quick Start
```bash
# Start target environment
./lab start nagios-cve-2016-9565-root-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell nagios-cve-2016-9565-root-rce
```

## Verification & Exploitation
```bash
curl http://localhost:8556/
```

## Video Walkthrough
- Walkthrough: [Nagios CVE-2016-9565-Root-RCE Security Assessment Walkthrough](https://www.youtube.com/watch?v=Lus7aNf2xDg)
