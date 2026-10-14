# Nexus - CVE-2024-4956

## Overview
- **Vulnerability ID**: CVE-2024-4956
- **Application**: Nexus
- **Port Allocation**: Port 8487
- **CLI Shortcut**: `./lab start nexus-cve-2024-4956`

## Vulnerability Description
Sonatype Nexus Repository Manager 3 unauthenticated directory traversal and arbitrary file disclosure.

## Quick Start
```bash
# Start target environment
./lab start nexus-cve-2024-4956

# View container status
./lab status

# Open interactive shell inside target
./lab shell nexus-cve-2024-4956
```

## Verification & Exploitation
```bash
curl http://localhost:8487/
```

## Video Walkthrough
- Walkthrough: [Nexus CVE-2024-4956 Security Assessment Walkthrough](https://www.youtube.com/watch?v=6dwLtc9m3Q4)
