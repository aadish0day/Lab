# Apache Shiro Ant-Style Path Normalization Authentication Bypass (CVE-2020-1957)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Shiro Ant-Style Path Normalization Authentication Bypass (CVE-2020-1957)** (CVE-2020-1957).

* **Target Directory**: `Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/shiro_path_traversal_bypass`
* **Default Port(s)**: `8219:8080`
* **CLI Shortcut**: `./lab start shiro-path-bypass`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_shiro_1957`
* **Upstream Image**: `vulhub/shiro:1.5.1`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Shiro path normalization discrepancy with Spring MVC leading to administrative authentication bypass.

### Technical Root Cause
In Apache Shiro before 1.5.2, discrepancies between how Shiro normalizes request URIs and how Spring Web interprets them allow attackers to append `/;/admin/index` to bypass Shiro's `authc` filter while Spring routes to the administrative handler.

---

## Defensive Remediation & Hardening
Upgrade Apache Shiro to version 1.5.2 or later. Ensure uniform URI normalization between middleware layers.

---

## Verified Video Walkthrough
* **Video Title**: [CAS Quick Tour - Apereo's Central Authentication Service (CAS) Single Sign-On](https://www.youtube.com/watch?v=TZUg4PUfS1M)
* **Direct URL**: https://www.youtube.com/watch?v=TZUg4PUfS1M
