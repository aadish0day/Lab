# Nginx HTTP Range Header Integer Overflow Information Disclosure (CVE-2017-7529)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Nginx HTTP Range Header Integer Overflow Information Disclosure (CVE-2017-7529)** (CVE-2017-7529).

* **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/nginx_cve_2017_7529`
* **Default Port(s)**: `8252:80`
* **CLI Shortcut**: `./lab start nginx-range-leak`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_nginx_range`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Nginx standard range filter integer overflow cache file header leakage.

### Technical Root Cause
An integer overflow in the ngx_http_range_filter_module permitted attackers to craft negative offset range headers that leaked internal cache file headers and backend response data.

---

## Defensive Remediation & Hardening
Upgrade Nginx to 1.13.3 or 1.12.1+.

---

## Verified Video Walkthrough
* **Video Title**: [Upgrading nginx 1.10.3 on Debian 9 (stretch) to avoid CVE-2017-7529 vulnerability](https://www.youtube.com/watch?v=Hx0rqVlsVv0)
* **Direct URL**: https://www.youtube.com/watch?v=Hx0rqVlsVv0
