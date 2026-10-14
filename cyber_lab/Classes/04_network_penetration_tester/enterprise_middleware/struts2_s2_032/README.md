# Struts2 - S2-032

## Overview
- **Vulnerability ID**: CVE-2016-3081
- **Application**: Struts2
- **Port Allocation**: Port 8504
- **CLI Shortcut**: `./lab start struts2-s2-032`

## Vulnerability Description
Apache Struts 2 Dynamic Method Invocation (DMI) OGNL expression injection RCE.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-032

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-032
```

## Verification & Exploitation
```bash
curl http://localhost:8504/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-032 Security Assessment Walkthrough](https://www.youtube.com/watch?v=9n90Y6GPmBU)
