# Ntopng - CVE-2021-28073

## Overview
- **Vulnerability ID**: CVE-2021-28073
- **Application**: Ntopng
- **Port Allocation**: Port 8450
- **CLI Shortcut**: `./lab start ntopng-cve-2021-28073`

## Vulnerability Description
Ntopng is a passive network monitoring tool focused on flows and statistics that can be obtained from the traffic captured by the server.

## Quick Start
```bash
# Start target environment
./lab start ntopng-cve-2021-28073

# View container status
./lab status

# Open interactive shell inside target
./lab shell ntopng-cve-2021-28073
```

## Verification & Exploitation
```bash
curl http://localhost:8450/
```

## Video Walkthrough
- Walkthrough: [ntopng Network Traffic Monitor Security Walkthrough](https://www.youtube.com/watch?v=1OvVwZgqnlo)
