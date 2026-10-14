# Apache Solr RunExecutableListener Remote Code Execution (CVE-2017-12629)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Solr RunExecutableListener Remote Code Execution (CVE-2017-12629)** (CVE-2017-12629).

* **Target Directory**: `Classes/02_web_penetration_tester/11_ssti_template_injection/solr_cve_2017_12629`
* **Default Port(s)**: `8198:8983`
* **CLI Shortcut**: `./lab start solr-runexec-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_solr_rce`
* **Upstream Image**: `vulhub/solr:7.0.1`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Solr ConfigAPI post-index listener registration leading to arbitrary binary execution.

### Technical Root Cause
Apache Solr before 7.1.0 exposes the ConfigAPI (`/solr/<core>/config`), allowing unauthenticated attackers to register a `RunExecutableListener` that invokes system commands when indexing documents.

---

## Defensive Remediation & Hardening
Upgrade Apache Solr to version 7.1.0 or newer. Restrict access to Solr administration endpoints.

---

## Verified Video Walkthrough
* **Video Title**: [Apache Solr remote code execution](https://www.youtube.com/watch?v=dPEsjj3eONU)
* **Direct URL**: https://www.youtube.com/watch?v=dPEsjj3eONU
