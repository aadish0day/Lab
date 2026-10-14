# Apache Solr RunExecutableListener XML External Entity Injection (CVE-2017-12629-XXE)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Solr RunExecutableListener XML External Entity Injection (CVE-2017-12629-XXE)** (CVE-2017-12629-XXE).

* **Target Directory**: `Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/solr_xxe_cve_2017_12629`
* **Default Port(s)**: `8255:8983`
* **CLI Shortcut**: `./lab start solr-xxe-injection`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_solr_xxe`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Solr add-listener XML parser external entity injection.

### Technical Root Cause
The Config API add-listener feature in Apache Solr processed XML payloads without disabling DTD entity expansion, enabling local file disclosure and SSRF.

---

## Defensive Remediation & Hardening
Upgrade Apache Solr to 7.1.0 or higher and disable external entity resolution.

---

## Verified Video Walkthrough
* **Video Title**: [Apache Solr remote code execution](https://www.youtube.com/watch?v=dPEsjj3eONU)
* **Direct URL**: https://www.youtube.com/watch?v=dPEsjj3eONU
