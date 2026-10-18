# Flask-Vulnerable-App - Python-SSTI-SQLI

## Overview

- **Vulnerability ID**: FLASK-VULN
- **Application**: Flask-Vulnerable-App
- **Port Allocation**: Port 8480
- **CLI Shortcut**: `./lab start flask-vulnerable-app-python-ssti-sqli`

## Vulnerability Description

Vulnerable Python Flask web application demonstrating Server-Side Template Injection and auth bypass.

## Quick Start

```bash
# Start target environment
./lab start flask-vulnerable-app-python-ssti-sqli

# View container status
./lab status

# Open interactive shell inside target
./lab shell flask-vulnerable-app-python-ssti-sqli
```

## Verification & Exploitation

```bash
curl http://localhost:8480/
```

## Video Walkthrough

- Walkthrough: [Flask-Vulnerable-App Python-SSTI-SQLI Security Assessment Walkthrough](https://www.youtube.com/watch?v=4TJlREKMZMk)
