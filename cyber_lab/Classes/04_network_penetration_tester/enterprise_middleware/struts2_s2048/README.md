# Apache Struts 2 Struts 1 Plugin ActionForm OGNL RCE (S2-048 / CVE-2017-9791)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache Struts 2 Struts 1 Plugin ActionForm OGNL RCE (S2-048 / CVE-2017-9791)** (CVE-2017-9791).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2048`
- **Default Port(s)**: `8209:8080`
- **CLI Shortcut**: `./lab start struts2-s2048`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_struts2_s2048`
- **Upstream Image**: `vulhub/struts2:2.3.32-showcase`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache Struts 2 Struts 1 plugin unsafe ActionForm property evaluation leading to OGNL injection.

### Technical Root Cause

When using the Struts 1 plugin in Struts 2.3.x, form field data processed through `ActionForm` is passed to `ActionSupport.getText()`, which evaluates the message key as an OGNL expression, allowing attackers to execute arbitrary system commands.

---

## Defensive Remediation & Hardening

Upgrade to Apache Struts 2.3.33 or 2.5.10.1 or remove the legacy Struts 1 plugin.

---

## Verified Video Walkthrough

- **Video Title**: [CVE 2017 9791 Apache Struts2 S2 048 remote code execution vulnerability](https://www.youtube.com/watch?v=RHbAmxnIDeY)
- **Direct URL**: https://www.youtube.com/watch?v=RHbAmxnIDeY
