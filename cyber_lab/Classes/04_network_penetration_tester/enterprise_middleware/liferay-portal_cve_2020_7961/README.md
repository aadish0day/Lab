# Liferay-portal - CVE-2020-7961

## Overview

- **Vulnerability ID**: CVE-2020-7961
- **Application**: Liferay-portal
- **Port Allocation**: Port 8441
- **CLI Shortcut**: `./lab start middleware-liferay-portal-cve-2020-7961`

## Vulnerability Description

Liferay Portal CE is an open-source platform for rapid website development. Versions 7.2.0 GA1 and earlier contain a deserialization vulnerability in the API interface, allowing attackers to execute arbitrary commands on the target server via crafted requests.

## Quick Start

```bash
# Start target environment
./lab start middleware-liferay-portal-cve-2020-7961

# View container status
./lab status

# Open interactive shell inside target
./lab shell middleware-liferay-portal-cve-2020-7961
```

## Verification & Exploitation

```bash
curl http://localhost:8441/
```

## Video Walkthrough

- Walkthrough: [Liferay Portal Java Deserialization RCE](https://www.youtube.com/watch?v=dn3DZHkcGh0)
