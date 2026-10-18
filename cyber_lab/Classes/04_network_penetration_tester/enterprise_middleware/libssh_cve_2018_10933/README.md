# Libssh - CVE-2018-10933

## Overview

- **Vulnerability ID**: CVE-2018-10933
- **Application**: Libssh
- **Port Allocation**: Port 8440
- **CLI Shortcut**: `./lab start libssh-cve-2018-10933`

## Vulnerability Description

libssh is a multiplatform C library implementing the SSHv2 protocol on client and server side. A logic vulnerability was found in libssh's server-side state machine. The attacker can send the `MSG_USERAUTH_SUCCESS` message before the authentication succeed. That can bypass the authentication and access the target SSH server.

## Quick Start

```bash
# Start target environment
./lab start libssh-cve-2018-10933

# View container status
./lab status

# Open interactive shell inside target
./lab shell libssh-cve-2018-10933
```

## Verification & Exploitation

```bash
curl http://localhost:8440/
```

## Video Walkthrough

- Walkthrough: [libssh Authentication Bypass Vulnerability Walkthrough](https://www.youtube.com/watch?v=MiaEWNruYdI)
