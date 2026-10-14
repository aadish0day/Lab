# CmsEasy - cut-image-rce

## Overview
- **Vulnerability ID**: CMSEASY-CUT-IMG
- **Application**: CmsEasy
- **Port Allocation**: Port 8517
- **CLI Shortcut**: `./lab start cmseasy-cut-image-rce`

## Vulnerability Description
CmsEasy cut_image function parameter tampering arbitrary file write and command execution.

## Quick Start
```bash
# Start target environment
./lab start cmseasy-cut-image-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell cmseasy-cut-image-rce
```

## Verification & Exploitation
```bash
curl http://localhost:8517/
```

## Video Walkthrough
- Walkthrough: [CmsEasy cut-image-rce Security Assessment Walkthrough](https://www.youtube.com/watch?v=F2PXe_o7KqM)
