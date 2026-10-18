# OWASP-WebGoat - WebGoat-Enterprise

## Overview

- **Vulnerability ID**: WEBGOAT-STANDALONE
- **Application**: OWASP-WebGoat
- **Port Allocation**: Port 8521
- **CLI Shortcut**: `./lab start owasp-webgoat-webgoat-enterprise`

## Vulnerability Description

OWASP WebGoat deliberately insecure Java web application designed to teach application security.

## Quick Start

```bash
# Start target environment
./lab start owasp-webgoat-webgoat-enterprise

# View container status
./lab status

# Open interactive shell inside target
./lab shell owasp-webgoat-webgoat-enterprise
```

## Verification & Exploitation

```bash
curl http://localhost:8521/
```

## Video Walkthrough

- Walkthrough: [OWASP-WebGoat WebGoat-Enterprise Security Assessment Walkthrough](https://www.youtube.com/watch?v=FOC2qDbxRwM)
