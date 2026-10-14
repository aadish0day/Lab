# Apache Struts 2 Tag Attribute Double Evaluation OGNL RCE (S2-059 / CVE-2020-17530)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Struts 2 Tag Attribute Double Evaluation OGNL RCE (S2-059 / CVE-2020-17530)** (CVE-2020-17530).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2059`
* **Default Port(s)**: `8211:8080`
* **CLI Shortcut**: `./lab start struts2-s2059`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_struts2_s2059`
* **Upstream Image**: `vulhub/struts2:2.5.16`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Struts 2 tag attribute double evaluation vulnerability allowing remote code execution.

### Technical Root Cause
Certain tag attributes in Struts 2.0.0 through 2.5.25 (such as `id` in `<s:url>`) perform recursive forced OGNL evaluation when rendered. An attacker submitting `%{...}` syntax can evaluate arbitrary OGNL payloads despite earlier sandbox restrictions.

---

## Defensive Remediation & Hardening
Upgrade Apache Struts to version 2.5.26 or later.

---

## Verified Video Walkthrough
* **Video Title**: [apache struts vulnerability | CVE-2020-17530 PoC](https://www.youtube.com/watch?v=MUAAwijvAe8)
* **Direct URL**: https://www.youtube.com/watch?v=MUAAwijvAe8
