# OpenSSH - CVE-2017-1000117

## Overview
- **Vulnerability ID**: CVE-2017-1000117
- **Application**: OpenSSH
- **Port Allocation**: Port 8539
- **CLI Shortcut**: `./lab start openssh-cve-2017-1000117`

## Vulnerability Description
OpenSSH command injection vulnerability via malicious hostname parameter handling.

## Quick Start
```bash
# Start target environment
./lab start openssh-cve-2017-1000117

# View container status
./lab status

# Open interactive shell inside target
./lab shell openssh-cve-2017-1000117
```

## Verification & Exploitation
```bash
curl http://localhost:8539/
```

## Video Walkthrough
- Walkthrough: [OpenSSH CVE-2017-1000117 Security Assessment Walkthrough](https://www.youtube.com/watch?v=In-XF5sY1Yo)
