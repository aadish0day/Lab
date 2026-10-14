# Apache Unomi MVEL & OGNL Expression Injection RCE (CVE-2020-13942)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Unomi MVEL & OGNL Expression Injection RCE (CVE-2020-13942)** (CVE-2020-13942).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/unomi_cve_2020_13942`
* **Default Port(s)**: `8241:8181`
* **CLI Shortcut**: `./lab start unomi-mvel-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_unomi_rce`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Unomi MVEL and OGNL expression evaluation RCE.

### Technical Root Cause
Unomi evaluated MVEL and OGNL expressions in custom conditions without sandbox isolation, allowing unauthenticated attackers to execute system commands.

---

## Defensive Remediation & Hardening
Upgrade Apache Unomi to 1.5.2 or later.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2020-13942 PoC | Apache Unomi Vulnerability](https://www.youtube.com/watch?v=iz6wjdGnpds)
* **Direct URL**: https://www.youtube.com/watch?v=iz6wjdGnpds
