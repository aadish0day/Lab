# Django QuerySet.order_by Raw Column SQL Injection (CVE-2021-35042)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Django QuerySet.order_by Raw Column SQL Injection (CVE-2021-35042)** (CVE-2021-35042).

* **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/django_cve_2021_35042`
* **Default Port(s)**: `8237:8000`
* **CLI Shortcut**: `./lab start django-orderby-sqli`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_django_orderby`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Django QuerySet order_by clause SQL injection via dotted path columns.

### Technical Root Cause
Unchecked column names containing dotted expressions were appended directly to ORDER BY statements, leading to arbitrary SQL injection.

---

## Defensive Remediation & Hardening
Upgrade Django to 3.2.5, 3.1.13, or 2.2.24.

---

## Verified Video Walkthrough
* **Video Title**: [Django #sqli | CVE-2021-35042](https://www.youtube.com/watch?v=GLdqXN7pNrU)
* **Direct URL**: https://www.youtube.com/watch?v=GLdqXN7pNrU
