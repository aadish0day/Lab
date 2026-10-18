# WordPress-Finder - Cysteme-Finder-LFI

## Overview

- **Vulnerability ID**: WP-FINDER-LFI
- **Application**: WordPress-Finder
- **Port Allocation**: Port 8512
- **CLI Shortcut**: `./lab start wordpress-finder-cysteme-finder-lfi`

## Vulnerability Description

WordPress CYSTEME Finder 1.3 plugin arbitrary local file read and source disclosure vulnerability.

## Quick Start

```bash
# Start target environment
./lab start wordpress-finder-cysteme-finder-lfi

# View container status
./lab status

# Open interactive shell inside target
./lab shell wordpress-finder-cysteme-finder-lfi
```

## Verification & Exploitation

```bash
curl http://localhost:8512/
```

## Video Walkthrough

- Walkthrough: [WordPress-Finder Cysteme-Finder-LFI Security Assessment Walkthrough](https://www.youtube.com/watch?v=DqrBQbxLZmw)
