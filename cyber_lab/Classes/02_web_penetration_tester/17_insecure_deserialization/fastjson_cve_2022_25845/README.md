# Fastjson 1.2.80/1.2.83 AutoType Bypass Remote Code Execution (CVE-2022-25845)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Fastjson 1.2.80/1.2.83 AutoType Bypass Remote Code Execution (CVE-2022-25845)** (CVE-2022-25845).

* **Target Directory**: `Classes/02_web_penetration_tester/17_insecure_deserialization/fastjson_cve_2022_25845`
* **Default Port(s)**: `8254:8090`
* **CLI Shortcut**: `./lab start fastjson-1283-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_fastjson_1283`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Fastjson 1.2.80 AutoType bypass via Throwable / exception class deserialization.

### Technical Root Cause
Fastjson allowed deserialization of classes inheriting from java.lang.Throwable or AutoCloseable even when safeMode was disabled, permitting arbitrary gadget instantiation and RCE.

---

## Defensive Remediation & Hardening
Enable safeMode in Fastjson or migrate to Fastjson2 with explicit class safelists.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2026-16723: Fastjson RCE — The Safe Version Is the Vulnerable Version](https://www.youtube.com/watch?v=FLsg8Q4GJ3M)
* **Direct URL**: https://www.youtube.com/watch?v=FLsg8Q4GJ3M
