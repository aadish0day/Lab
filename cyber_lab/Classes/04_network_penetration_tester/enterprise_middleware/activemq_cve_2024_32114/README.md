# Apache ActiveMQ Jolokia Arbitrary File Write & Code Execution (CVE-2024-32114)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache ActiveMQ Jolokia Arbitrary File Write & Code Execution (CVE-2024-32114)** (CVE-2024-32114).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2024_32114`
* **Default Port(s)**: `8257:8161, 61620:61616`
* **CLI Shortcut**: `./lab start activemq-jolokia-filewrite`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_activemq_611`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache ActiveMQ Jolokia arbitrary file write and webshell execution.

### Technical Root Cause
An arbitrary file write flaw in the Jolokia JMX bridge allowed authenticated console users to overwrite system files or write JSP shells to web directories.

---

## Defensive Remediation & Hardening
Upgrade Apache ActiveMQ to 6.1.2 or 5.18.4+.

---

## Verified Video Walkthrough
* **Video Title**: [Apache ActiveMQ: Remote code execution vulnerability in Apache ActiveMQ via Jo...(CVE-2026-34197)](https://www.youtube.com/watch?v=809wx-p6FT4)
* **Direct URL**: https://www.youtube.com/watch?v=809wx-p6FT4
