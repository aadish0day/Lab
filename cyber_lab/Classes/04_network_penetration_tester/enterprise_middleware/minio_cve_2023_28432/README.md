# Minio - CVE-2023-28432

## Overview

- **Vulnerability ID**: CVE-2023-28432
- **Application**: Minio
- **Port Allocation**: Port 8444
- **CLI Shortcut**: `./lab start minio-cve-2023-28432`

## Vulnerability Description

MinIO is a High Performance Object Storage released under GNU Affero General Public License v3.0.

## Quick Start

```bash
# Start target environment
./lab start minio-cve-2023-28432

# View container status
./lab status

# Open interactive shell inside target
./lab shell minio-cve-2023-28432
```

## Verification & Exploitation

```bash
curl http://localhost:8444/
```

## Video Walkthrough

- Walkthrough: [Cybersecurity Vulnerability Walkthrough Tutorial](https://www.youtube.com/watch?v=MiaEWNruYdI)
