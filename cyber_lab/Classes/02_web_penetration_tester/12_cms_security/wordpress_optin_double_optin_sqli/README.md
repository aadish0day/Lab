# WordPress-OptIn - Double-OptIn-SQLi

## Overview
- **Vulnerability ID**: WP-OPTIN-SQLI
- **Application**: WordPress-OptIn
- **Port Allocation**: Port 8514
- **CLI Shortcut**: `./lab start wordpress-optin-double-optin-sqli`

## Vulnerability Description
WordPress Double Opt-In for Download plugin unauthenticated SQL injection vulnerability.

## Quick Start
```bash
# Start target environment
./lab start wordpress-optin-double-optin-sqli

# View container status
./lab status

# Open interactive shell inside target
./lab shell wordpress-optin-double-optin-sqli
```

## Verification & Exploitation
```bash
curl http://localhost:8514/
```

## Video Walkthrough
- Walkthrough: [WordPress-OptIn Double-OptIn-SQLi Security Assessment Walkthrough](https://www.youtube.com/watch?v=EgE1i3AcUX8)
