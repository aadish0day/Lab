# Ingress-nginx - CVE-2025-1974

## Overview

- **Vulnerability ID**: CVE-2025-1974
- **Application**: Ingress-nginx
- **Port Allocation**: Port 8396
- **CLI Shortcut**: `./lab start cloud-ingress-nginx-cve-2025-1974`

## Vulnerability Description

[中文版本(Chinese version)](README.zh-cn.md)

## Quick Start

```bash
# Start target environment
./lab start cloud-ingress-nginx-cve-2025-1974

# View container status
./lab status

# Open interactive shell inside target
./lab shell cloud-ingress-nginx-cve-2025-1974
```

## Verification & Exploitation

```bash
curl http://localhost:8396/
```

## Video Walkthrough

- Walkthrough: [Ingress NGINX Annotation Vulnerability Walkthrough](https://www.youtube.com/watch?v=1OvVwZgqnlo)
