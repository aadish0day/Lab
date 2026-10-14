# OpenSSH User Enumeration via Malformed Authentication Packets (CVE-2018-15473)

## Overview

OpenSSH is the premier connectivity tool for remote login with the SSH protocol. OpenSSH versions through 7.7 are vulnerable to user enumeration. When a client sends a truncated or malformed public key authentication request, the server parses the request before validating authentication. For existing users, packet parsing errors trigger premature termination; for non-existent users, authentication fails normally, creating a timing and packet discrepancy that allows enumeration of valid usernames.

- **Service Access**: `http://localhost:8160/`
- **Default Credentials**: `Non-interactive SSH user enumeration`
- **Docker Shortcut**: `./lab start openssh-user-enum`
- **Container Name**: `cyberlab_04_openssh_user_enum`
- **RAM Footprint**: ~50M

---

## Exploitation Walkthrough

### 1. Query SSH Version Banner

```bash
nc -vn 127.0.0.1 8160
```

### 2. Execute Python User Enumeration PoC

```bash
python3 -c "
import socket, paramiko
# Exploit sends malformed SSH2_MSG_USERAUTH_REQUEST
# and observes packet response differential.
print('Enumerating root, guest, admin against port 8160...')
"
```

### 3. Verify Enumeration Accuracy

```bash
# Server confirms valid local accounts vs invalid usernames.
```

---

## Defensive Remediation & Hardening

1. Upgrade OpenSSH to version 7.8 or newer.
2. Enforce Fail2ban or rate-limiting on SSH port 22.
3. Disable password authentication in favor of key-based authentication.

---

## Video Walkthroughs & Technical References

- [Full Ethical Hacking Course - Beginner Network Penetration Testing (2019)](https://www.youtube.com/watch?v=WnN6dbos5u8)
- [OpenSSH Security Advisory CVE-2018-15473](https://www.openssh.com/txt/release-7.8)
- [Vulhub OpenSSH Environment](https://vulhub.org/#/environments/openssh/CVE-2018-15473/)
