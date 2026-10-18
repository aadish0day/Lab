# PHP imap_open SSH Command Injection RCE (CVE-2018-19518)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **PHP imap_open SSH Command Injection RCE (CVE-2018-19518)** (CVE-2018-19518).

- **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/php_imap_cve_2018_19518`
- **Default Port(s)**: `8249:80`
- **CLI Shortcut**: `./lab start php-imap-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_php_imap`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

PHP imap_open server mailbox string SSH command execution.

### Technical Root Cause

The mailbox parameter in imap_open passed hostname strings directly to rsh/ssh commands without sanitization, allowing an attacker to inject -oProxyCommand parameters and execute arbitrary commands.

---

## Defensive Remediation & Hardening

Upgrade c-client and PHP packages, validate and whitelist mail server hostnames, and disable CL_EXPUNGE on untrusted input.

---

## Verified Video Walkthrough

- **Video Title**: [vulhub漏洞復現 php/CVE-2018-19518](https://www.youtube.com/watch?v=aSSISGkplfc)
- **Direct URL**: https://www.youtube.com/watch?v=aSSISGkplfc
