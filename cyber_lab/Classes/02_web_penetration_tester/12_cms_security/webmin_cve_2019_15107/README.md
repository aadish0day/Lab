# Webmin - CVE-2019-15107

## Overview

- **Vulnerability ID**: CVE-2019-15107
- **Application**: Webmin
- **Port Allocation**: Port 8474
- **CLI Shortcut**: `./lab start webmin-cve-2019-15107`

## Vulnerability Description

Webmin password change CGI parameter command injection vulnerability yielding root access.

## Quick Start

```bash
# Start target environment
./lab start webmin-cve-2019-15107

# View container status
./lab status

# Open interactive shell inside target
./lab shell webmin-cve-2019-15107
```

## Verification & Exploitation

```bash
curl http://localhost:8474/
```

## Video Walkthrough

- Walkthrough: [Webmin CVE-2019-15107 Security Assessment Walkthrough](https://www.youtube.com/watch?v=33VZ7RvMkgM)
