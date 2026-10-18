# Struts2 - S2-029

## Overview

- **Vulnerability ID**: S2-029-OGNL
- **Application**: Struts2
- **Port Allocation**: Port 8543
- **CLI Shortcut**: `./lab start struts2-s2-029`

## Vulnerability Description

Apache Struts 2 I18n tag attribute double OGNL evaluation remote code execution.

## Quick Start

```bash
# Start target environment
./lab start struts2-s2-029

# View container status
./lab status

# Open interactive shell inside target
./lab shell struts2-s2-029
```

## Verification & Exploitation

```bash
curl http://localhost:8543/
```

## Video Walkthrough

- Walkthrough: [Struts2 S2-029 Security Assessment Walkthrough](https://www.youtube.com/watch?v=Jf3ZeL7lGog)
