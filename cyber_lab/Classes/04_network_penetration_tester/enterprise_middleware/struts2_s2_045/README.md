# Struts2 - S2-045

## Overview
- **Vulnerability ID**: CVE-2017-5638
- **Application**: Struts2
- **Port Allocation**: Port 8540
- **CLI Shortcut**: `./lab start struts2-s2-045`

## Vulnerability Description
Apache Struts 2 Jakarta Multipart parser Content-Type header OGNL remote code execution.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-045

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-045
```

## Verification & Exploitation
```bash
curl http://localhost:8540/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-045 Security Assessment Walkthrough](https://www.youtube.com/watch?v=IrZOlqio0nw)
