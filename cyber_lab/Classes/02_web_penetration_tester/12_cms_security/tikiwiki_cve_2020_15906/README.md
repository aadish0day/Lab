# Tiki Wiki Administrator Password Reset Authentication Bypass (CVE-2020-15906)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Tiki Wiki Administrator Password Reset Authentication Bypass (CVE-2020-15906)** (CVE-2020-15906).

- **Target Directory**: `Classes/02_web_penetration_tester/12_cms_security/tikiwiki_cve_2020_15906`
- **Default Port(s)**: `8268:80`
- **CLI Shortcut**: `./lab start tikiwiki-auth-bypass`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_tikiwiki_bypass`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Tiki Wiki brute-force protection logic flaw leading to admin password reset.

### Technical Root Cause

When an attacker exceeded the failed login threshold on Tiki Wiki <= 21.1, the application set the admin password hash to an empty string in the database, allowing subsequent login with a blank password.

---

## Defensive Remediation & Hardening

Upgrade Tiki Wiki to version 21.2 or higher.

---

## Verified Video Walkthrough

- **Video Title**: [Backtrack tikiwiki exploit](https://www.youtube.com/watch?v=9P8N4LOqquw)
- **Direct URL**: https://www.youtube.com/watch?v=9P8N4LOqquw
