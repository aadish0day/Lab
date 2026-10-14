# PHP 8.1.0-dev User-Agentt Backdoor Remote Code Execution

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **PHP 8.1.0-dev User-Agentt Backdoor Remote Code Execution** (CVE-2021-3129-PHP).

* **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/php_81_backdoor_rce`
* **Default Port(s)**: `8248:80`
* **CLI Shortcut**: `./lab start php-backdoor-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_php_81_backdoor`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
PHP 8.1.0-dev development branch User-Agentt header backdoor RCE.

### Technical Root Cause
An intentional backdoor was committed into the PHP git repository source in March 2021. If an HTTP request header begins with User-Agentt, the server extracts and executes arbitrary PHP code via zend_eval_string.

---

## Defensive Remediation & Hardening
Replace compromised PHP 8.1.0-dev binaries immediately with official release distributions.

---

## Verified Video Walkthrough
* **Video Title**: [Exploiting a backdoor in PHP 8.1.0-dev | Knife @ HackTheBox](https://www.youtube.com/watch?v=C-Uck0h5L9s)
* **Direct URL**: https://www.youtube.com/watch?v=C-Uck0h5L9s
