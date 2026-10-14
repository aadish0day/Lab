# Apache Struts 2 Namespace OGNL Injection RCE (S2-057 / CVE-2018-11776)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Struts 2 Namespace OGNL Injection RCE (S2-057 / CVE-2018-11776)** (CVE-2018-11776).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2057`
* **Default Port(s)**: `8196:8080`
* **CLI Shortcut**: `./lab start struts2-s2057`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_struts2_s2057`
* **Upstream Image**: `vulhub/struts2:2.3.34-showcase`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Struts 2 namespace evaluation flaw in action configurations leading to OGNL injection and code execution.

### Technical Root Cause
When action configurations do not define a namespace or use a wildcard namespace, Struts 2 evaluates the URL namespace as an OGNL expression during redirect action result processing.

---

## Defensive Remediation & Hardening
Upgrade Apache Struts to versions 2.3.35, 2.5.17 or newer. Explicitly configure action namespaces.

---

## Verified Video Walkthrough
* **Video Title**: [Apache Struts2 rce CVE-2018-11776](https://www.youtube.com/watch?v=oapuqp-mABc)
* **Direct URL**: https://www.youtube.com/watch?v=oapuqp-mABc
