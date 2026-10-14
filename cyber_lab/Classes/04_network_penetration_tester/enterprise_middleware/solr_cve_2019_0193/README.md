# Solr - CVE-2019-0193

## Overview
- **Vulnerability ID**: CVE-2019-0193
- **Application**: Solr
- **Port Allocation**: Port 8493
- **CLI Shortcut**: `./lab start solr-cve-2019-0193`

## Vulnerability Description
Apache Solr DataImportHandler script execution remote code execution vulnerability.

## Quick Start
```bash
# Start target environment
./lab start solr-cve-2019-0193

# View container status
./lab status

# Open interactive shell inside target
./lab shell solr-cve-2019-0193
```

## Verification & Exploitation
```bash
curl http://localhost:8493/
```

## Video Walkthrough
- Walkthrough: [Solr CVE-2019-0193 Security Assessment Walkthrough](https://www.youtube.com/watch?v=809wx-p6FT4)
