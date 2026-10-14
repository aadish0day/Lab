# Apache Struts 2 OGNL Sandbox Package Blacklist Bypass (S2-061 / CVE-2020-17558)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Struts 2 OGNL Sandbox Package Blacklist Bypass (S2-061 / CVE-2020-17558)** (CVE-2020-17558).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2061`
* **Default Port(s)**: `8212:8080`
* **CLI Shortcut**: `./lab start struts2-s2061`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_struts2_s2061`
* **Upstream Image**: `vulhub/struts2:2.5.25`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Struts 2 OGNL sandbox bypass using internal bean context manipulation to achieve code execution.

### Technical Root Cause
The fix for S2-059 was incomplete. Attackers can bypass the OGNL member access blacklist in Struts 2.5.25 through bean property manipulation (`#application.get('org.apache.tomcat.InstanceManager')`) to instantiate arbitrary Java classes.

---

## Defensive Remediation & Hardening
Upgrade Apache Struts to version 2.5.26 or newer.

---

## Verified Video Walkthrough
* **Video Title**: [Apache Struts Command Injection Vulnerability: CVE-2016-3081](https://www.youtube.com/watch?v=BxDdtHBZlRc)
* **Direct URL**: https://www.youtube.com/watch?v=BxDdtHBZlRc
