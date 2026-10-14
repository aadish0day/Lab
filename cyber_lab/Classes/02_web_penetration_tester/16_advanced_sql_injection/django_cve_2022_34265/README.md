# Django Trunc & Extract Database Functions SQL Injection (CVE-2022-34265)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Django Trunc & Extract Database Functions SQL Injection (CVE-2022-34265)** (CVE-2022-34265).

* **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/django_cve_2022_34265`
* **Default Port(s)**: `8238:8000`
* **CLI Shortcut**: `./lab start django-trunc-sqli`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_django_trunc`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Django Trunc and Extract date/time database functions SQL injection.

### Technical Root Cause
The kind and lookup_name parameters in Trunc() and Extract() functions were not validated, allowing SQL injection via untrusted inputs.

---

## Defensive Remediation & Hardening
Upgrade Django to 4.0.6, 3.2.14 or later.

---

## Verified Video Walkthrough
* **Video Title**: [Django SQL Injection](https://www.youtube.com/watch?v=urhqo6puILQ)
* **Direct URL**: https://www.youtube.com/watch?v=urhqo6puILQ
