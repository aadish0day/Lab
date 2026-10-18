# Memcached - CVE-2016-8704-Append-Overflow

## Overview

- **Vulnerability ID**: CVE-2016-8704
- **Application**: Memcached
- **Port Allocation**: Port 8557
- **CLI Shortcut**: `./lab start memcached-cve-2016-8704-append-overflow`

## Vulnerability Description

Memcached server process_bin_append_prepend remote integer overflow and heap corruption.

## Quick Start

```bash
# Start target environment
./lab start memcached-cve-2016-8704-append-overflow

# View container status
./lab status

# Open interactive shell inside target
./lab shell memcached-cve-2016-8704-append-overflow
```

## Verification & Exploitation

```bash
curl http://localhost:8557/
```

## Video Walkthrough

- Walkthrough: [Memcached CVE-2016-8704-Append-Overflow Security Assessment Walkthrough](https://www.youtube.com/watch?v=M4csb7eQrf8)
