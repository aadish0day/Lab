# Tomcat - CVE-2020-1938-Ghostcat

## Overview
- **Vulnerability ID**: CVE-2020-1938
- **Application**: Tomcat
- **Port Allocation**: Port 8534
- **CLI Shortcut**: `./lab start tomcat-cve-2020-1938-ghostcat`

## Vulnerability Description
Apache Tomcat AJP protocol 'Ghostcat' file read and remote code execution vulnerability.

## Quick Start
```bash
# Start target environment
./lab start tomcat-cve-2020-1938-ghostcat

# View container status
./lab status

# Open interactive shell inside target
./lab shell tomcat-cve-2020-1938-ghostcat
```

## Verification & Exploitation
```bash
curl http://localhost:8534/
```

## Video Walkthrough
- Walkthrough: [Tomcat CVE-2020-1938-Ghostcat Security Assessment Walkthrough](https://www.youtube.com/watch?v=I5XAN_pkfIY)
