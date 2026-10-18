# Apache ActiveMQ OpenWire Deserialization Remote Code Execution (CVE-2023-46604)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache ActiveMQ OpenWire Deserialization Remote Code Execution (CVE-2023-46604)** (CVE-2023-46604).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2023_46604`
- **Default Port(s)**: `8204:8161, 61617:61616`
- **CLI Shortcut**: `./lab start activemq-openwire-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_activemq_46604`
- **Upstream Image**: `vulhub/activemq:5.17.3`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache ActiveMQ OpenWire broker unauthenticated class instantiation leading to remote code execution.

### Technical Root Cause

In the OpenWire protocol unmarshaling implementation, `ExceptionResponse` allows clients to specify an arbitrary class name and string parameter. The broker instantiates classes like `org.springframework.context.support.ClassPathXmlApplicationContext` with a remote XML URL, triggering arbitrary Java code execution.

---

## Defensive Remediation & Hardening

Upgrade Apache ActiveMQ to versions 5.15.16, 5.16.7, 5.17.6, 5.18.3 or later. Block untrusted access to OpenWire port 61616.

---

## Verified Video Walkthrough

- **Video Title**: [Hack The Box Broker Walkthrough | Apache ActiveMQ CVE-2023-46604 Exploit & Nginx Priv Esc](https://www.youtube.com/watch?v=FvvdxA11-ZU)
- **Direct URL**: https://www.youtube.com/watch?v=FvvdxA11-ZU
