# Struts2 - S2-013

## Overview
- **Vulnerability ID**: CVE-2013-1966
- **Application**: Struts2
- **Port Allocation**: Port 8548
- **CLI Shortcut**: `./lab start struts2-s2-013`

## Vulnerability Description
Apache Struts 2 include and URL tag parameter evaluation OGNL remote code execution.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-013

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-013
```

## Verification & Exploitation
```bash
curl http://localhost:8548/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-013 Security Assessment Walkthrough](https://www.youtube.com/watch?v=K7XBQWAZdZ4)
