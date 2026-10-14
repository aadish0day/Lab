# Laravel Ignition Debug Mode Deserialization RCE (CVE-2021-3129)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Laravel Ignition Debug Mode Deserialization RCE (CVE-2021-3129)** (CVE-2021-3129).

* **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/laravel_ignition_rce`
* **Default Port(s)**: `8187:80`
* **CLI Shortcut**: `./lab start laravel-ignition-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_laravel`
* **Upstream Image**: `vulhub/laravel:8.4.2`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Laravel Ignition error handler execute-solution endpoint arbitrary Phar deserialization RCE.

### Technical Root Cause
When `APP_DEBUG=true`, Laravel uses Facade Ignition before version 2.5.2. The `_ignition/execute-solution` endpoint accepts arbitrary solution parameters that trigger file operations through `file_get_contents`, enabling Phar deserialization gadget chains.

---

## Defensive Remediation & Hardening
Set `APP_DEBUG=false` in production environments and upgrade facade/ignition to version 2.5.2 or newer.

---

## Verified Video Walkthrough
* **Video Title**: [#laravel debug mode rce | CVE-2021-3129 PoC](https://www.youtube.com/watch?v=kxtgTiRJ-wg)
* **Direct URL**: https://www.youtube.com/watch?v=kxtgTiRJ-wg
