# Struts2 - S2-033

## Overview
- **Vulnerability ID**: CVE-2016-3087
- **Application**: Struts2
- **Port Allocation**: Port 8542
- **CLI Shortcut**: `./lab start struts2-s2-033`

## Vulnerability Description
Apache Struts 2 REST plugin Dynamic Method Invocation OGNL expression injection RCE.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-033

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-033
```

## Verification & Exploitation
```bash
curl http://localhost:8542/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-033 Security Assessment Walkthrough](https://www.youtube.com/watch?v=JYoySps-844)
