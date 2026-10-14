# Elasticsearch Groovy Dynamic Scripting Sandbox Bypass RCE (CVE-2015-1427)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Elasticsearch Groovy Dynamic Scripting Sandbox Bypass RCE (CVE-2015-1427)** (CVE-2015-1427).

* **Target Directory**: `Classes/02_web_penetration_tester/22_nosql_injection/elasticsearch_groovy_cve_2015_1427`
* **Default Port(s)**: `8253:9200`
* **CLI Shortcut**: `./lab start elasticsearch-groovy-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_es_groovy`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Elasticsearch Groovy dynamic search script execution sandbox escape RCE.

### Technical Root Cause
The Groovy scripting sandbox in Elasticsearch 1.4.0 through 1.4.2 failed to prevent reflective invocation of arbitrary Java methods via java.lang.Math and ClassLoader chaining.

---

## Defensive Remediation & Hardening
Disable dynamic scripting by setting script.groovy.sandbox.enabled = false or upgrade to 1.4.3+.

---

## Verified Video Walkthrough
* **Video Title**: [SomeDayPWN: CVE-2015-1427 Proof of Concept](https://www.youtube.com/watch?v=VckaMBA3XRw)
* **Direct URL**: https://www.youtube.com/watch?v=VckaMBA3XRw
