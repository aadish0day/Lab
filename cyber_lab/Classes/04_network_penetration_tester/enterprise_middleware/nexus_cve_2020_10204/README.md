# Nexus - CVE-2020-10204

## Overview
- **Vulnerability ID**: CVE-2020-10204
- **Application**: Nexus
- **Port Allocation**: Port 8486
- **CLI Shortcut**: `./lab start nexus-cve-2020-10204`

## Vulnerability Description
Sonatype Nexus Repository Manager 3 authenticated Remote Code Execution via helper template injection.

## Quick Start
```bash
# Start target environment
./lab start nexus-cve-2020-10204

# View container status
./lab status

# Open interactive shell inside target
./lab shell nexus-cve-2020-10204
```

## Verification & Exploitation
```bash
curl http://localhost:8486/
```

## Video Walkthrough
- Walkthrough: [Nexus CVE-2020-10204 Security Assessment Walkthrough](https://www.youtube.com/watch?v=6ZuzA333qV8)
