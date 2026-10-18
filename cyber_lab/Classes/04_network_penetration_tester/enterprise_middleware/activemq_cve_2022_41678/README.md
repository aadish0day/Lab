# Apache ActiveMQ Jolokia JMX Remote Code Execution (CVE-2022-41678)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache ActiveMQ Jolokia JMX Remote Code Execution (CVE-2022-41678)** (CVE-2022-41678).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2022_41678`
- **Default Port(s)**: `8256:8161, 61619:61616`
- **CLI Shortcut**: `./lab start activemq-jolokia-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_activemq_jolokia`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache ActiveMQ Jolokia REST API MBean instantiation code execution.

### Technical Root Cause

Authenticated users on the ActiveMQ web console could abuse the Jolokia REST endpoint to execute MBean operations and write arbitrary JSP webshells via Log4j Appenders.

---

## Defensive Remediation & Hardening

Upgrade Apache ActiveMQ to 5.17.6 or 5.18.3+ and restrict Jolokia API access.

---

## Verified Video Walkthrough

- **Video Title**: [Exploits ActiveMQ CVE-2023-46604 RCE (Python) #ActiveMQ #RCE #Exploit #Python #linux #cybersec #ctf](https://www.youtube.com/watch?v=Mbb9PMrd2H4)
- **Direct URL**: https://www.youtube.com/watch?v=Mbb9PMrd2H4
