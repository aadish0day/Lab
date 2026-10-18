# PHP-FPM env_path_info Underflow Remote Code Execution (CVE-2019-11043)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **PHP-FPM env_path_info Underflow Remote Code Execution (CVE-2019-11043)** (CVE-2019-11043).

- **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/php_fpm_cve_2019_11043`
- **Default Port(s)**: `8267:80`
- **CLI Shortcut**: `./lab start php-fpm-underflow-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_php_fpm`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

PHP-FPM pointer underflow in path_info leading to arbitrary FCGI code execution.

### Technical Root Cause

An arithmetic underflow in fpm_main.c when parsing PATH_INFO in Nginx fastcgi configurations allowed attackers to write to FCGI buffers and set arbitrary PHP configuration directives.

---

## Defensive Remediation & Hardening

Upgrade PHP to 7.1.33, 7.2.24, or 7.3.11+, and ensure fastcgi_split_path_info verifies target file existence.

---

## Verified Video Walkthrough

- **Video Title**: [CVE-2019-11043: PHP-FPM Remote Code Execution (RCE) Technical Analysis & Patch](https://www.youtube.com/watch?v=cPUVsX9qmA8)
- **Direct URL**: https://www.youtube.com/watch?v=cPUVsX9qmA8
