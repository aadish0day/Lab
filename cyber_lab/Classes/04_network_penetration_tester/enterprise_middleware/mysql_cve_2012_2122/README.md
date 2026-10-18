# Mysql - CVE-2012-2122

## Overview

- **Vulnerability ID**: CVE-2012-2122
- **Application**: Mysql
- **Port Allocation**: Port 8446
- **CLI Shortcut**: `./lab start mysql-cve-2012-2122`

## Vulnerability Description

When connecting to MariaDB/MySQL, the input password is compared with the expected correct password. Due to improper handling, even if memcmp() returns a non-zero value, MySQL may still consider the two passwords to be identical. This means that with just a username, repeated login attempts can lead to successful database access.

## Quick Start

```bash
# Start target environment
./lab start mysql-cve-2012-2122

# View container status
./lab status

# Open interactive shell inside target
./lab shell mysql-cve-2012-2122
```

## Verification & Exploitation

```bash
curl http://localhost:8446/
```

## Video Walkthrough

- Walkthrough: [MySQL Authentication Bypass and Injection Demo](https://www.youtube.com/watch?v=ptajUIqk_Ao)
