# Craft CMS 4 Pre-Authentication Template Engine Remote Code Execution (CVE-2023-41892)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Craft CMS 4 Pre-Authentication Template Engine Remote Code Execution (CVE-2023-41892)** (CVE-2023-41892).

* **Target Directory**: `Classes/02_web_penetration_tester/12_cms_security/craftcms_cve_2023_41892`
* **Default Port(s)**: `8234:80`
* **CLI Shortcut**: `./lab start craftcms-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_craftcms_rce`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Craft CMS 4 unauthenticated template injection and arbitrary code execution.

### Technical Root Cause
Craft CMS conditions controller allowed unauthenticated attackers to evaluate arbitrary PHP callables via crafted template evaluation parameters.

---

## Defensive Remediation & Hardening
Upgrade Craft CMS to version 4.4.15 or later.

---

## Verified Video Walkthrough
* **Video Title**: [Craft CMS CVE-2023-41892 Vulnerability Exploitation | POC](https://www.youtube.com/watch?v=iR39Kaez_eM)
* **Direct URL**: https://www.youtube.com/watch?v=iR39Kaez_eM
