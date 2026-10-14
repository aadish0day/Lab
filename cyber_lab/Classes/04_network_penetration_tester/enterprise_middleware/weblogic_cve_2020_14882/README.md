# Oracle WebLogic Console Authentication Bypass & Code Execution (CVE-2020-14882)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Oracle WebLogic Console Authentication Bypass & Code Execution (CVE-2020-14882)** (CVE-2020-14882).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/weblogic_cve_2020_14882`
* **Default Port(s)**: `8203:7001`
* **CLI Shortcut**: `./lab start weblogic-console-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_weblogic_14882`
* **Upstream Image**: `vulhub/weblogic:12.2.1.3-2018`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Oracle WebLogic Server Administration Console unauthenticated path traversal and code execution.

### Technical Root Cause
An unauthenticated remote attacker can bypass authentication in the WebLogic console via double-encoded path traversal sequences (`/console/css/%252e%252e%252fconsole.portal`) and chain execution through MBean classes like `com.tangosol.coherence.mvel2.MVELFilter` or `FileSystemXmlApplicationContext`.

---

## Defensive Remediation & Hardening
Apply Oracle Critical Patch Update patches for CVE-2020-14882 and CVE-2020-14750. Restrict external network access to administration port 7001.

---

## Verified Video Walkthrough
* **Video Title**: [WebLogic Vulnerabilities - PeopleSoft Impact (CVE-2020-14882 and CVE-2020-14750)](https://www.youtube.com/watch?v=-dc_vLdYEtA)
* **Direct URL**: https://www.youtube.com/watch?v=-dc_vLdYEtA
