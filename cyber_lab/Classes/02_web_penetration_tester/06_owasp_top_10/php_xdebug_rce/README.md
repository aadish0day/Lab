# PHP Xdebug Remote Debugging Unauthenticated Code Execution

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **PHP Xdebug Remote Debugging Unauthenticated Code Execution** (CWE-94).

* **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/php_xdebug_rce`
* **Default Port(s)**: `8250:80`
* **CLI Shortcut**: `./lab start php-xdebug-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_php_xdebug`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
PHP Xdebug DBGp protocol remote debugging command execution.

### Technical Root Cause
When xdebug.remote_connect_back is enabled without IP filtering, Xdebug connects back to incoming client IP addresses on port 9000 and accepts DBGp eval commands, enabling arbitrary PHP code execution.

---

## Defensive Remediation & Hardening
Disable xdebug.remote_connect_back in production and bind xdebug.remote_host strictly to trusted internal IPs or localhost.

---

## Verified Video Walkthrough
* **Video Title**: [Remote Code Execution via File Upload | RCE | Unrestricted File Upload](https://www.youtube.com/watch?v=q9F_xIi0Xzo)
* **Direct URL**: https://www.youtube.com/watch?v=q9F_xIi0Xzo
