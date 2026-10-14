# Struts2 - S2-015

## Overview
- **Vulnerability ID**: CVE-2013-2135
- **Application**: Struts2
- **Port Allocation**: Port 8547
- **CLI Shortcut**: `./lab start struts2-s2-015`

## Vulnerability Description
Apache Struts 2 wildcard matching action execution OGNL expression injection vulnerability.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-015

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-015
```

## Verification & Exploitation
```bash
curl http://localhost:8547/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-015 Security Assessment Walkthrough](https://www.youtube.com/watch?v=K5FdAVVeeb8)
