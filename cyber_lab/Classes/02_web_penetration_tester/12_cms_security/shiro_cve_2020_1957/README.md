# Shiro - CVE-2020-1957

## Overview
- **Vulnerability ID**: CVE-2020-1957
- **Application**: Shiro
- **Port Allocation**: Port 8473
- **CLI Shortcut**: `./lab start shiro-cve-2020-1957`

## Vulnerability Description
Apache Shiro Spring framework integration request path authorization bypass vulnerability.

## Quick Start
```bash
# Start target environment
./lab start shiro-cve-2020-1957

# View container status
./lab status

# Open interactive shell inside target
./lab shell shiro-cve-2020-1957
```

## Verification & Exploitation
```bash
curl http://localhost:8473/
```

## Video Walkthrough
- Walkthrough: [Shiro CVE-2020-1957 Security Assessment Walkthrough](https://www.youtube.com/watch?v=2jVNXLMYEqM)
