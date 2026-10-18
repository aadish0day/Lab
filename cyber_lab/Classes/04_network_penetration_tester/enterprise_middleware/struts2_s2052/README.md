# Apache Struts 2 REST Plugin XStream Deserialization RCE (S2-052 / CVE-2017-9805)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache Struts 2 REST Plugin XStream Deserialization RCE (S2-052 / CVE-2017-9805)** (CVE-2017-9805).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2052`
- **Default Port(s)**: `8197:8080`
- **CLI Shortcut**: `./lab start struts2-s2052`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_struts2_s2052`
- **Upstream Image**: `vulhub/struts2:2.5.12-rest-showcase`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache Struts 2 REST plugin unsafe XStream deserialization handling XML payloads.

### Technical Root Cause

Struts 2 REST plugin uses an unconfigured `XStreamHandler` to deserialize XML request bodies, allowing attackers to submit serialized Java object gadget chains that execute arbitrary system commands.

---

## Defensive Remediation & Hardening

Upgrade Apache Struts to version 2.5.13 or newer. Replace XStreamHandler with secure JSON/XML parsers.

---

## Verified Video Walkthrough

- **Video Title**: [S2-052 (CVE-2017-9805) showcase](https://www.youtube.com/watch?v=FhORuceZ45o)
- **Direct URL**: https://www.youtube.com/watch?v=FhORuceZ45o
