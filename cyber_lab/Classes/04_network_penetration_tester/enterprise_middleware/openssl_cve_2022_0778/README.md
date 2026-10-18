# Openssl - CVE-2022-0778

## Overview

- **Vulnerability ID**: CVE-2022-0778
- **Application**: Openssl
- **Port Allocation**: Port 8455
- **CLI Shortcut**: `./lab start openssl-cve-2022-0778`

## Vulnerability Description

OpenSSL is a software library for applications that secure communications over computer networks against eavesdropping or need to identify the party at the other end.

## Quick Start

```bash
# Start target environment
./lab start openssl-cve-2022-0778

# View container status
./lab status

# Open interactive shell inside target
./lab shell openssl-cve-2022-0778
```

## Verification & Exploitation

```bash
curl http://localhost:8455/
```

## Video Walkthrough

- Walkthrough: [OpenSSL Cryptographic Vulnerability Demo](https://www.youtube.com/watch?v=MiaEWNruYdI)
