# Solr - REMOTE-STREAMING-FILEREAD

## Overview

- **Vulnerability ID**: REMOTE-STREAMING-FILEREAD
- **Application**: Solr
- **Port Allocation**: Port 8322
- **CLI Shortcut**: `./lab start solr-remote-streaming-filere`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start solr-remote-streaming-filere

# View container status
./lab status

# Open interactive shell inside target
./lab shell solr-remote-streaming-filere
```

## Verification & Exploitation

```bash
curl http://localhost:8322/
```

## Video Walkthrough

- Walkthrough: [Apache Solr Vulnerability Walkthrough](https://www.youtube.com/watch?v=YZLnfjM3cg4)
