# PHPMailer - CVE-2016-10033

## Overview

- **Vulnerability ID**: CVE-2016-10033
- **Application**: PHPMailer
- **Port Allocation**: Port 8515
- **CLI Shortcut**: `./lab start phpmailer-cve-2016-10033`

## Vulnerability Description

PHPMailer library Sender header shell argument injection vulnerability leading to remote code execution.

## Quick Start

```bash
# Start target environment
./lab start phpmailer-cve-2016-10033

# View container status
./lab status

# Open interactive shell inside target
./lab shell phpmailer-cve-2016-10033
```

## Verification & Exploitation

```bash
curl http://localhost:8515/
```

## Video Walkthrough

- Walkthrough: [PHPMailer CVE-2016-10033 Security Assessment Walkthrough](https://www.youtube.com/watch?v=EpXabc1XdmM)
