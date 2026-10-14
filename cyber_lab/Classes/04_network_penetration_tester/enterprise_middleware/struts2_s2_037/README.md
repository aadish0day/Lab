# Struts2 - S2-037

## Overview
- **Vulnerability ID**: CVE-2016-4438
- **Application**: Struts2
- **Port Allocation**: Port 8541
- **CLI Shortcut**: `./lab start struts2-s2-037`

## Vulnerability Description
Apache Struts 2 REST plugin method name parameter OGNL expression evaluation RCE.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-037

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-037
```

## Verification & Exploitation
```bash
curl http://localhost:8541/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-037 Security Assessment Walkthrough](https://www.youtube.com/watch?v=JC4-iXWpTuA)
