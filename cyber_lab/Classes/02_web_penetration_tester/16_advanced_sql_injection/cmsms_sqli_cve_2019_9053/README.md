# CMS Made Simple Time-Based Blind SQL Injection (CVE-2019-9053)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **CMS Made Simple Time-Based Blind SQL Injection (CVE-2019-9053)** (CVE-2019-9053).

* **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/cmsms_sqli_cve_2019_9053`
* **Default Port(s)**: `8259:80`
* **CLI Shortcut**: `./lab start cmsms-blind-sqli`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_cmsms_sqli`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
CMS Made Simple News module unauthenticated time-based blind SQL injection.

### Technical Root Cause
Unauthenticated attackers could inject time-based SQL payloads into the m1_idlist parameter in the News module to dump administrator password hashes and salts.

---

## Defensive Remediation & Hardening
Upgrade CMS Made Simple to version 2.2.10 or later.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2019-9053 Walkthrough | TryHackMe Simple CTF](https://www.youtube.com/watch?v=kad8ZrdgW8U)
* **Direct URL**: https://www.youtube.com/watch?v=kad8ZrdgW8U
