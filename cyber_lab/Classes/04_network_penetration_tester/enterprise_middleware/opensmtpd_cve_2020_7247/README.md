# Opensmtpd - CVE-2020-7247

## Overview

- **Vulnerability ID**: CVE-2020-7247
- **Application**: Opensmtpd
- **Port Allocation**: Port 8453
- **CLI Shortcut**: `./lab start opensmtpd-cve-2020-7247`

## Vulnerability Description

OpenSMTPD is an smtp service program for unix operating systems (BSD, MacOS, GNU/Linux), following the RFC 5321 SMTP protocol. OpenSMTPD was originally developed for the OpenBSD operating system and is part of the OpenBSD project. Due to its open source properties, Distributed to other unix platforms. According to the ISC license, the software is free for everyone to use and reuse.

## Quick Start

```bash
# Start target environment
./lab start opensmtpd-cve-2020-7247

# View container status
./lab status

# Open interactive shell inside target
./lab shell opensmtpd-cve-2020-7247
```

## Verification & Exploitation

```bash
curl http://localhost:8453/
```

## Video Walkthrough

- Walkthrough: [OpenSMTPD Mail Server Remote Code Execution](https://www.youtube.com/watch?v=MiaEWNruYdI)
