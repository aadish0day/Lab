# Struts2 - S2-057

## Overview

- **Vulnerability ID**: CVE-2018-11776
- **Application**: Struts2
- **Port Allocation**: Port 8536
- **CLI Shortcut**: `./lab start struts2-s2-057`

## Vulnerability Description

Apache Struts 2 namespace configuration OGNL expression injection leading to remote code execution.

## Quick Start

```bash
# Start target environment
./lab start struts2-s2-057

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-057
```

## Verification & Exploitation

```bash
curl http://localhost:8536/
```

## Video Walkthrough

- Walkthrough: [Struts2 S2-057 Security Assessment Walkthrough](https://www.youtube.com/watch?v=IO4FjTflU6s)
