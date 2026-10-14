# Nginx URI Resolution Null Byte Security Bypass RCE (CVE-2013-4547)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Nginx URI Resolution Null Byte Security Bypass RCE (CVE-2013-4547)** (CVE-2013-4547).

* **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/nginx_cve_2013_4547`
* **Default Port(s)**: `8251:8080`
* **CLI Shortcut**: `./lab start nginx-nullbyte-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_nginx_nullbyte`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Nginx whitespace and null byte URI parsing restriction bypass leading to PHP execution.

### Technical Root Cause
In Nginx 0.8.41 through 1.4.3 / 1.5.7, an unescaped space character followed by a null byte in a URI permitted an attacker to bypass file extension restrictions and execute non-PHP files as PHP scripts.

---

## Defensive Remediation & Hardening
Upgrade Nginx to version 1.4.4 or 1.5.8 and enforce strict file extension checks in FastCGI locations.

---

## Verified Video Walkthrough
* **Video Title**: [Unauth RCE in Ingress NGINX (CVE-2025-1974)](https://www.youtube.com/watch?v=bJ1hZnqNRZM)
* **Direct URL**: https://www.youtube.com/watch?v=bJ1hZnqNRZM
