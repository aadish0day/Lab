# Struts2 - S2-019

## Overview
- **Vulnerability ID**: CVE-2013-4316
- **Application**: Struts2
- **Port Allocation**: Port 8544
- **CLI Shortcut**: `./lab start struts2-s2-019`

## Vulnerability Description
Apache Struts 2 Dynamic Method Invocation enabled parameter evaluation remote code execution.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-019

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-019
```

## Verification & Exploitation
```bash
curl http://localhost:8544/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-019 Security Assessment Walkthrough](https://www.youtube.com/watch?v=JinJ_6EQ--s)
