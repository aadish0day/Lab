# Nacos - CVE-2021-29442

## Overview
- **Vulnerability ID**: CVE-2021-29442
- **Application**: Nacos
- **Port Allocation**: Port 8448
- **CLI Shortcut**: `./lab start nacos-cve-2021-29442`

## Vulnerability Description
Nacos is an easy-to-use platform designed for dynamic service discovery and configuration and service management.

## Quick Start
```bash
# Start target environment
./lab start nacos-cve-2021-29442

# View container status
./lab status

# Open interactive shell inside target
./lab shell nacos-cve-2021-29442
```

## Verification & Exploitation
```bash
curl http://localhost:8448/
```

## Video Walkthrough
- Walkthrough: [Alibaba Nacos Dynamic Service Platform Security](https://www.youtube.com/watch?v=dn3DZHkcGh0)
