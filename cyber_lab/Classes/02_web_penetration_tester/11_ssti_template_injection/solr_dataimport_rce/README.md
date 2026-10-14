# Apache Solr DataImportHandler ScriptTransformer Remote Code Execution (CVE-2019-0193)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Solr DataImportHandler ScriptTransformer Remote Code Execution (CVE-2019-0193)** (CVE-2019-0193).

* **Target Directory**: `Classes/02_web_penetration_tester/11_ssti_template_injection/solr_dataimport_rce`
* **Default Port(s)**: `8216:8983`
* **CLI Shortcut**: `./lab start solr-dataimport-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_solr_dataimport`
* **Upstream Image**: `vulhub/solr:8.1.1`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Solr DataImportHandler custom script configuration leading to Java/Nashorn script execution.

### Technical Root Cause
Apache Solr before 8.2.0 allows users to provide dynamic `dataConfig` XML payloads via the `/solr/<core>/dataimport` endpoint. Attackers configure a `ScriptTransformer` containing arbitrary JavaScript evaluated by the Java Nashorn engine to achieve RCE.

---

## Defensive Remediation & Hardening
Upgrade Apache Solr to version 8.2.0 or newer. Ensure DataImportHandler configuration is read-only.

---

## Verified Video Walkthrough
* **Video Title**: [Solr RCE- CVE-2019-0193-Demo](https://www.youtube.com/watch?v=9n90Y6GPmBU)
* **Direct URL**: https://www.youtube.com/watch?v=9n90Y6GPmBU
