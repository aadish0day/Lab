# Memcached - CVE-2016-8705-Update-Overflow

## Overview
- **Vulnerability ID**: CVE-2016-8705
- **Application**: Memcached
- **Port Allocation**: Port 8558
- **CLI Shortcut**: `./lab start memcached-cve-2016-8705-update-overflow`

## Vulnerability Description
Memcached server process_bin_update remote integer overflow leading to code execution.

## Quick Start
```bash
# Start target environment
./lab start memcached-cve-2016-8705-update-overflow

# View container status
./lab status

# Open interactive shell inside target
./lab shell memcached-cve-2016-8705-update-overflow
```

## Verification & Exploitation
```bash
curl http://localhost:8558/
```

## Video Walkthrough
- Walkthrough: [Memcached CVE-2016-8705-Update-Overflow Security Assessment Walkthrough](https://www.youtube.com/watch?v=M7IwpC9WpIg)
