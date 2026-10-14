# Scrapy - scrapyd-unacc

## Overview
- **Vulnerability ID**: SCRAPYD-UNAUTH
- **Application**: Scrapy
- **Port Allocation**: Port 8470
- **CLI Shortcut**: `./lab start scrapy-scrapyd-unacc`

## Vulnerability Description
Scrapyd web service unauthenticated JSON API exposure allowing arbitrary spider execution.

## Quick Start
```bash
# Start target environment
./lab start scrapy-scrapyd-unacc

# View container status
./lab status

# Open interactive shell inside target
./lab shell scrapy-scrapyd-unacc
```

## Verification & Exploitation
```bash
curl http://localhost:8470/
```

## Video Walkthrough
- Walkthrough: [Scrapy scrapyd-unacc Security Assessment Walkthrough](https://www.youtube.com/watch?v=1dDvEmlLpWE)
