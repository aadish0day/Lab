# Django CommonMiddleware APPEND_SLASH Open Redirect Vulnerability (CVE-2018-14574)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Django CommonMiddleware APPEND_SLASH Open Redirect Vulnerability (CVE-2018-14574)** (CVE-2018-14574).

* **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/django_cve_2018_14574`
* **Default Port(s)**: `8235:8000`
* **CLI Shortcut**: `./lab start django-open-redirect`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_django_redirect`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Django CommonMiddleware malformed URL redirect vulnerability.

### Technical Root Cause
When APPEND_SLASH was enabled, malformed URLs with leading slashes bypassed domain validation in HttpResponseRedirect, enabling open redirection.

---

## Defensive Remediation & Hardening
Upgrade Django to versions 2.0.8, 1.11.15 or later.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2018-11784: Open Redirect Vulnerability - Bug Bounty PoC | Bug Bounty University](https://www.youtube.com/watch?v=lDGbCxFVXwQ)
* **Direct URL**: https://www.youtube.com/watch?v=lDGbCxFVXwQ
