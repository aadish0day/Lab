# Phpmyadmin - CVE-2018-12613

## Overview
- **Vulnerability ID**: CVE-2018-12613
- **Application**: Phpmyadmin
- **Port Allocation**: Port 8431
- **CLI Shortcut**: `./lab start phpmyadmin-cve-2018-12613`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start phpmyadmin-cve-2018-12613

# View container status
./lab status

# Open interactive shell inside target
./lab shell phpmyadmin-cve-2018-12613
```

## Verification & Exploitation
```bash
curl http://localhost:8431/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
