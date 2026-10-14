# Apache Struts 2 Freemarker Template Double Evaluation OGNL RCE (S2-053 / CVE-2017-12611)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Struts 2 Freemarker Template Double Evaluation OGNL RCE (S2-053 / CVE-2017-12611)** (CVE-2017-12611).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2053`
* **Default Port(s)**: `8210:8080`
* **CLI Shortcut**: `./lab start struts2-s2053`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_struts2_s2053`
* **Upstream Image**: `vulhub/struts2:s2-053`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Struts 2 Freemarker XML/tag attribute expression double evaluation leading to remote code execution.

### Technical Root Cause
When Freemarker templates in Struts 2 evaluate dynamic tag attributes like `<@s.hidden name="${redirectName}"/>`, user input embedded in the value is evaluated a second time as an OGNL expression, permitting remote command execution.

---

## Defensive Remediation & Hardening
Upgrade Apache Struts to 2.5.12 or newer. Avoid evaluating untrusted parameters in Freemarker tags.

---

## Verified Video Walkthrough
* **Video Title**: [Struts2 Shell001 Apache Struts 2 CVE 2017 5638 Exploit {BETA}](https://www.youtube.com/watch?v=zLwC7tzCXOw)
* **Direct URL**: https://www.youtube.com/watch?v=zLwC7tzCXOw
