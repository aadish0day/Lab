# Struts2 - S2-016

## Overview
- **Vulnerability ID**: CVE-2013-2251
- **Application**: Struts2
- **Port Allocation**: Port 8546
- **CLI Shortcut**: `./lab start struts2-s2-016`

## Vulnerability Description
Apache Struts 2 redirect action prefix parameter OGNL expression execution vulnerability.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-016

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-016
```

## Verification & Exploitation
```bash
curl http://localhost:8546/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-016 Security Assessment Walkthrough](https://www.youtube.com/watch?v=Ju3Wc6S0GhM)
