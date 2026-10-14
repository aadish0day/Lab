# Git - CVE-2018-11235

## Overview
- **Vulnerability ID**: CVE-2018-11235
- **Application**: Git
- **Port Allocation**: Port 8520
- **CLI Shortcut**: `./lab start git-cve-2018-11235`

## Vulnerability Description
Git submodule path traversal vulnerability leading to arbitrary code execution on client clone.

## Quick Start
```bash
# Start target environment
./lab start git-cve-2018-11235

# View container status
./lab status

# Open interactive shell inside target
./lab shell git-cve-2018-11235
```

## Verification & Exploitation
```bash
curl http://localhost:8520/
```

## Video Walkthrough
- Walkthrough: [Git CVE-2018-11235 Security Assessment Walkthrough](https://www.youtube.com/watch?v=FLsg8Q4GJ3M)
