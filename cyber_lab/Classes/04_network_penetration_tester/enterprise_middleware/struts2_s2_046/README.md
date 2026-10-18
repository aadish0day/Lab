# Struts2 - S2-046

## Overview

- **Vulnerability ID**: CVE-2017-5638
- **Application**: Struts2
- **Port Allocation**: Port 8505
- **CLI Shortcut**: `./lab start middleware-struts2-s2-046`

## Vulnerability Description

Apache Struts 2 multipart parser null-byte injection OGNL remote code execution.

## Quick Start

```bash
# Start target environment
./lab start middleware-struts2-s2-046

# View container status
./lab status

# Open interactive shell inside target
./lab shell middleware-struts2-s2-046
```

## Verification & Exploitation

```bash
curl http://localhost:8505/
```

## Video Walkthrough

- Walkthrough: [Struts2 S2-046 Security Assessment Walkthrough](https://www.youtube.com/watch?v=B7p8dIB7bFg)
