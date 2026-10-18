# Shiro - CVE-2010-3863

## Overview

- **Vulnerability ID**: CVE-2010-3863
- **Application**: Shiro
- **Port Allocation**: Port 8471
- **CLI Shortcut**: `./lab start shiro-cve-2010-3863`

## Vulnerability Description

Apache Shiro URI normalization authentication bypass vulnerability.

## Quick Start

```bash
# Start target environment
./lab start shiro-cve-2010-3863

# View container status
./lab status

# Open interactive shell inside target
./lab shell shiro-cve-2010-3863
```

## Verification & Exploitation

```bash
curl http://localhost:8471/
```

## Video Walkthrough

- Walkthrough: [Shiro CVE-2010-3863 Security Assessment Walkthrough](https://www.youtube.com/watch?v=1dOCHwf8zVQ)
