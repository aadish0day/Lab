# Phpmyadmin - WOOYUN-2016-199433

## Overview
- **Vulnerability ID**: WOOYUN-2016-199433
- **Application**: Phpmyadmin
- **Port Allocation**: Port 8298
- **CLI Shortcut**: `./lab start phpmyadmin-wooyun-2016-19943`

## Vulnerability Description
[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start
```bash
# Start target environment
./lab start phpmyadmin-wooyun-2016-19943

# View container status
./lab status

# Open interactive shell inside target
./lab shell phpmyadmin-wooyun-2016-19943
```

## Verification & Exploitation
```bash
curl http://localhost:8298/
```

## Video Walkthrough
- Walkthrough: [phpMyAdmin Security Analysis and Tutorial](https://www.youtube.com/watch?v=vmSTJI3gFSg)
