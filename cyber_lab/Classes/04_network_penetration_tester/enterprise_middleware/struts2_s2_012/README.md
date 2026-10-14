# Struts2 - S2-012

## Overview
- **Vulnerability ID**: CVE-2013-1965
- **Application**: Struts2
- **Port Allocation**: Port 8549
- **CLI Shortcut**: `./lab start struts2-s2-012`

## Vulnerability Description
Apache Struts 2 Showcase application redirect action parameter OGNL evaluation RCE.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-012

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-012
```

## Verification & Exploitation
```bash
curl http://localhost:8549/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-012 Security Assessment Walkthrough](https://www.youtube.com/watch?v=KY58WcX7OZ4)
