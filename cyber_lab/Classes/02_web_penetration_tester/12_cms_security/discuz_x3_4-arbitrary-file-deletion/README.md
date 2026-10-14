# Discuz - X3.4-ARBITRARY-FILE-DELETION

## Overview
- **Vulnerability ID**: X3.4-ARBITRARY-FILE-DELETION
- **Application**: Discuz
- **Port Allocation**: Port 8273
- **CLI Shortcut**: `./lab start discuz-x3.4-arbitrary-file-d`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start discuz-x3.4-arbitrary-file-d

# View container status
./lab status

# Open interactive shell inside target
./lab shell discuz-x3.4-arbitrary-file-d
```

## Verification & Exploitation
```bash
curl http://localhost:8273/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
