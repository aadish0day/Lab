# Tomcat - TOMCAT8

## Overview

- **Vulnerability ID**: TOMCAT8
- **Application**: Tomcat
- **Port Allocation**: Port 8330
- **CLI Shortcut**: `./lab start tomcat-tomcat8`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start tomcat-tomcat8

# View container status
./lab status

# Open interactive shell inside target
./lab shell tomcat-tomcat8
```

## Verification & Exploitation

```bash
curl http://localhost:8330/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
