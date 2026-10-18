# Ffmpeg - CVE-2016-1897

## Overview

- **Vulnerability ID**: CVE-2016-1897
- **Application**: Ffmpeg
- **Port Allocation**: Port 8405
- **CLI Shortcut**: `./lab start ffmpeg-cve-2016-1897`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start ffmpeg-cve-2016-1897

# View container status
./lab status

# Open interactive shell inside target
./lab shell ffmpeg-cve-2016-1897
```

## Verification & Exploitation

```bash
curl http://localhost:8405/
```

## Video Walkthrough

- Walkthrough: [FFmpeg HLS File Read Vulnerability Walkthrough](https://www.youtube.com/watch?v=bZGDrNmCRWo)
