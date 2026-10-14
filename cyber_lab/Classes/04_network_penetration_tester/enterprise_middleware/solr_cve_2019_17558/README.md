# Solr - CVE-2019-17558

## Overview
- **Vulnerability ID**: CVE-2019-17558
- **Application**: Solr
- **Port Allocation**: Port 8494
- **CLI Shortcut**: `./lab start solr-cve-2019-17558`

## Vulnerability Description
Apache Solr Velocity response writer remote code execution vulnerability.

## Quick Start
```bash
# Start target environment
./lab start solr-cve-2019-17558

# View container status
./lab status

# Open interactive shell inside target
./lab shell solr-cve-2019-17558
```

## Verification & Exploitation
```bash
curl http://localhost:8494/
```

## Video Walkthrough
- Walkthrough: [Solr CVE-2019-17558 Security Assessment Walkthrough](https://www.youtube.com/watch?v=8Dcj19KGKWM)
