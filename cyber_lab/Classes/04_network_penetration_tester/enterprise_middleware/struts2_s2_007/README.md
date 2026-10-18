# Struts2 - S2-007

## Overview

- **Vulnerability ID**: CVE-2012-0838
- **Application**: Struts2
- **Port Allocation**: Port 8551
- **CLI Shortcut**: `./lab start struts2-s2-007`

## Vulnerability Description

Apache Struts 2 form validation type conversion error message OGNL expression execution.

## Quick Start

```bash
# Start target environment
./lab start struts2-s2-007

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-007
```

## Verification & Exploitation

```bash
curl http://localhost:8551/
```

## Video Walkthrough

- Walkthrough: [Struts2 S2-007 Security Assessment Walkthrough](https://www.youtube.com/watch?v=KbuXQPgigas)
