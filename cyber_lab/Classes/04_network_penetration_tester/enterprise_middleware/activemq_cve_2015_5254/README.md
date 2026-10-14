# Apache ActiveMQ ObjectMessage Java Deserialization RCE (CVE-2015-5254)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache ActiveMQ ObjectMessage Java Deserialization RCE (CVE-2015-5254)** (CVE-2015-5254).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2015_5254`
* **Default Port(s)**: `8245:8161, 61618:61616`
* **CLI Shortcut**: `./lab start activemq-objectmessage-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_activemq_5254`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache ActiveMQ ObjectMessage untrusted class deserialization RCE.

### Technical Root Cause
ActiveMQ did not enforce class whitelist filtering on ObjectMessage objects sent over OpenWire port 61616, enabling remote code execution via gadget chains.

---

## Defensive Remediation & Hardening
Upgrade ActiveMQ to 5.13.0 or later and configure allowed deserialization classes.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2026-34197: Hitachi Energy SOI ActiveMQ Exploit](https://www.youtube.com/watch?v=NBGgXq8QF2w)
* **Direct URL**: https://www.youtube.com/watch?v=NBGgXq8QF2w
