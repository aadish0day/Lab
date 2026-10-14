# WordPress-Mailpress - Mailpress-Plugin-RCE

## Overview
- **Vulnerability ID**: WP-MAILPRESS-RCE
- **Application**: WordPress-Mailpress
- **Port Allocation**: Port 8513
- **CLI Shortcut**: `./lab start wordpress-mailpress-mailpress-plugin-rce`

## Vulnerability Description
WordPress Mailpress plugin remote code execution vulnerability in autosave endpoint.

## Quick Start
```bash
# Start target environment
./lab start wordpress-mailpress-mailpress-plugin-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell wordpress-mailpress-mailpress-plugin-rce
```

## Verification & Exploitation
```bash
curl http://localhost:8513/
```

## Video Walkthrough
- Walkthrough: [WordPress-Mailpress Mailpress-Plugin-RCE Security Assessment Walkthrough](https://www.youtube.com/watch?v=EexflA75B7A)
