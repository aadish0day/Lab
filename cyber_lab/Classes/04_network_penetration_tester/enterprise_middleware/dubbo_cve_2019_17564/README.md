# Apache Dubbo HTTP Remoting Java Deserialization RCE (CVE-2019-17564)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache Dubbo HTTP Remoting Java Deserialization RCE (CVE-2019-17564)** (CVE-2019-17564).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/dubbo_cve_2019_17564`
- **Default Port(s)**: `8240:8080`
- **CLI Shortcut**: `./lab start dubbo-remoting-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_dubbo_remoting`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache Dubbo HTTP remoting native Java deserialization RCE.

### Technical Root Cause

Apache Dubbo HTTP remoting protocol passed POST bodies directly to ObjectInputStream.readObject() without type validation, allowing arbitrary gadget execution.

---

## Defensive Remediation & Hardening

Upgrade Apache Dubbo to version 2.7.5 or higher and disable unauthenticated HTTP remoting.

---

## Verified Video Walkthrough

- **Video Title**: [HackTheBox ~ Feline Walkthrough [Java Deserialization & Docker exploits f/ OSCP/OSWE]](https://www.youtube.com/watch?v=VkV_UPeVpPU)
- **Direct URL**: https://www.youtube.com/watch?v=VkV_UPeVpPU
