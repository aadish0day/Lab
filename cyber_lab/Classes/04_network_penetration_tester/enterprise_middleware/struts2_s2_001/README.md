# Struts2 - S2-001

## Overview
- **Vulnerability ID**: S2-001-EVAL
- **Application**: Struts2
- **Port Allocation**: Port 8552
- **CLI Shortcut**: `./lab start struts2-s2-001`

## Vulnerability Description
Apache Struts 2 form tag password field recursive OGNL evaluation remote code execution.

## Quick Start
```bash
# Start target environment
./lab start struts2-s2-001

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-001
```

## Verification & Exploitation
```bash
curl http://localhost:8552/
```

## Video Walkthrough
- Walkthrough: [Struts2 S2-001 Security Assessment Walkthrough](https://www.youtube.com/watch?v=L-YeZAhQdVM)
