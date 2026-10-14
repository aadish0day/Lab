# Spring Cloud Function SpEL Routing RCE (CVE-2022-22963)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Spring Cloud Function SpEL Routing RCE (CVE-2022-22963)** (CVE-2022-22963).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/spring_cloud_function_rce`
* **Default Port(s)**: `8195:8080`
* **CLI Shortcut**: `./lab start spring-function-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_spring_function`
* **Upstream Image**: `vulhub/spring-cloud-function:3.2.2`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Spring Cloud Function routing expression SpEL evaluation leading to unauthenticated remote code execution.

### Technical Root Cause
Spring Cloud Function versions through 3.2.2 evaluate the `spring.cloud.function.routing-expression` HTTP header as a Spring Expression Language (SpEL) string during request routing, allowing arbitrary command execution.

---

## Defensive Remediation & Hardening
Upgrade Spring Cloud Function to versions 3.1.7, 3.2.3 or higher. Disallow untrusted routing headers.

---

## Verified Video Walkthrough
* **Video Title**: [Bug Remote Code Execution (RCE) pada Spring Cloud Function (CVE-2022-22963)](https://www.youtube.com/watch?v=z3vAX6kNU4I)
* **Direct URL**: https://www.youtube.com/watch?v=z3vAX6kNU4I
