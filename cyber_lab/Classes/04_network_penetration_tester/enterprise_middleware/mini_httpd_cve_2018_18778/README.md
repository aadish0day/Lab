# Mini_httpd - CVE-2018-18778

## Overview
- **Vulnerability ID**: CVE-2018-18778
- **Application**: Mini_httpd
- **Port Allocation**: Port 8442
- **CLI Shortcut**: `./lab start mini_httpd-cve-2018-18778`

## Vulnerability Description
ACME mini_httpd is a tiny HTTP server that maintains a certain level of performance (about 90% of Apache) while consuming minimal system resources. Therefore, it is widely used as an embedded server in various IoT devices (routers, switches, cameras, etc.). Devices from manufacturers including Huawei, zyxel, Hikvision, and Raspberry Pi have used the Mini_httpd component.

## Quick Start
```bash
# Start target environment
./lab start mini_httpd-cve-2018-18778

# View container status
./lab status

# Open interactive shell inside target
./lab shell mini_httpd-cve-2018-18778
```

## Verification & Exploitation
```bash
curl http://localhost:8442/
```

## Video Walkthrough
- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
