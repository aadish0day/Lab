# Struts2 - S2-008

## Overview

- **Vulnerability ID**: CVE-2012-0391
- **Application**: Struts2
- **Port Allocation**: Port 8550
- **CLI Shortcut**: `./lab start struts2-s2-008`

## Vulnerability Description

Apache Struts 2 multiple parameter evaluation vulnerabilities resulting in arbitrary code execution.

## Quick Start

```bash
# Start target environment
./lab start struts2-s2-008

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-008
```

## Verification & Exploitation

```bash
curl http://localhost:8550/
```

## Video Walkthrough

- Walkthrough: [Struts2 S2-008 Security Assessment Walkthrough](https://www.youtube.com/watch?v=KbaOay1yOH0)
