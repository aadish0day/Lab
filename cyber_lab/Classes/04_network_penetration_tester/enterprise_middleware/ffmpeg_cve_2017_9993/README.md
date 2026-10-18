# Ffmpeg - CVE-2017-9993

## Overview

- **Vulnerability ID**: CVE-2017-9993
- **Application**: Ffmpeg
- **Port Allocation**: Port 8406
- **CLI Shortcut**: `./lab start ffmpeg-cve-2017-9993`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start ffmpeg-cve-2017-9993

# View container status
./lab status

# Open interactive shell inside target
./lab shell ffmpeg-cve-2017-9993
```

## Verification & Exploitation

```bash
curl http://localhost:8406/
```

## Video Walkthrough

- Walkthrough: [FFmpeg HLS File Read Vulnerability Walkthrough](https://www.youtube.com/watch?v=bZGDrNmCRWo)
