# Apache CXF Aegis DataBinding XML Parsing SSRF & Remote Execution (CVE-2024-28752)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache CXF Aegis DataBinding XML Parsing SSRF & Remote Execution (CVE-2024-28752)** (CVE-2024-28752).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/apache_cxf_cve_2024_28752`
* **Default Port(s)**: `8247:8080`
* **CLI Shortcut**: `./lab start cxf-ssrf-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_cxf_ssrf`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache CXF Aegis DataBinding schema parsing SSRF and remote execution.

### Technical Root Cause
Aegis DataBinding XML parser improperly processed schema locations and external entities, allowing unauthenticated attackers to trigger SSRF and remote execution.

---

## Defensive Remediation & Hardening
Upgrade Apache CXF to 3.5.8, 3.6.3, or 4.0.4+.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2024-28752 Apache CXF Aegis DataBinding SSRF Vulnerability Explained | #cve #poc #cybersecurity](https://www.youtube.com/watch?v=nBiKXgZ_WtE)
* **Direct URL**: https://www.youtube.com/watch?v=nBiKXgZ_WtE
