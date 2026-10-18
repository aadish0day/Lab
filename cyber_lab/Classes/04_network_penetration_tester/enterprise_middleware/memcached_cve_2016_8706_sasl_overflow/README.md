# Memcached - CVE-2016-8706-SASL-Overflow

## Overview

- **Vulnerability ID**: CVE-2016-8706
- **Application**: Memcached
- **Port Allocation**: Port 8559
- **CLI Shortcut**: `./lab start memcached-cve-2016-8706-sasl-overflow`

## Vulnerability Description

Memcached server process_bin_sasl_auth remote integer overflow in SASL authentication handling.

## Quick Start

```bash
# Start target environment
./lab start memcached-cve-2016-8706-sasl-overflow

# View container status
./lab status

# Open interactive shell inside target
./lab shell memcached-cve-2016-8706-sasl-overflow
```

## Verification & Exploitation

```bash
curl http://localhost:8559/
```

## Video Walkthrough

- Walkthrough: [Memcached CVE-2016-8706-SASL-Overflow Security Assessment Walkthrough](https://www.youtube.com/watch?v=MUAAwijvAe8)
