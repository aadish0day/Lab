# Phpunit - CVE-2017-9841

## Overview

- **Vulnerability ID**: CVE-2017-9841
- **Application**: Phpunit
- **Port Allocation**: Port 8432
- **CLI Shortcut**: `./lab start phpunit-cve-2017-9841`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start phpunit-cve-2017-9841

# View container status
./lab status

# Open interactive shell inside target
./lab shell phpunit-cve-2017-9841
```

## Verification & Exploitation

```bash
curl http://localhost:8432/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
