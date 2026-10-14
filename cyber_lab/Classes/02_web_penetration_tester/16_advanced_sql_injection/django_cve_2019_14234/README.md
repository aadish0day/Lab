# Django JSONField & HStoreField KeyTransform SQL Injection (CVE-2019-14234)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Django JSONField & HStoreField KeyTransform SQL Injection (CVE-2019-14234)** (CVE-2019-14234).

* **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/django_cve_2019_14234`
* **Default Port(s)**: `8236:8000`
* **CLI Shortcut**: `./lab start django-jsonfield-sqli`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_django_jsonfield`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Django JSONField key transform SQL injection in PostgreSQL backend.

### Technical Root Cause
Improper key sanitization in JSONField and HStoreField lookup parameters allowed attackers to inject arbitrary SQL statements through dictionary keys.

---

## Defensive Remediation & Hardening
Upgrade Django to 2.2.4, 2.1.11, or 1.11.23.

---

## Verified Video Walkthrough
* **Video Title**: [CRITICAL Django SQL Injection (CVE-2025-64459): Patch NOW or Get Hacked!](https://www.youtube.com/watch?v=Sj5-lFWqBu0)
* **Direct URL**: https://www.youtube.com/watch?v=Sj5-lFWqBu0
