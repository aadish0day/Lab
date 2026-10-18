# Spring Framework Spring4Shell ClassLoader RCE (CVE-2022-22965)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Spring Framework Spring4Shell ClassLoader RCE (CVE-2022-22965)** (CVE-2022-22965).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/spring_webmvc_spring4shell`
- **Default Port(s)**: `8194:8080`
- **CLI Shortcut**: `./lab start spring4shell-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_spring4shell`
- **Upstream Image**: `vulhub/spring-webmvc:5.3.17`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Spring MVC DataBinder class parameter binding flaw leading to Tomcat AccessLogValve manipulation and web shell generation.

### Technical Root Cause

Running Spring on JDK 9+ exposes `class.module.classLoader`. Attackers bind request parameters to Tomcat's `AccessLogValve` to write an arbitrary JSP payload into the web application root directory.

---

## Defensive Remediation & Hardening

Upgrade Spring Framework to 5.3.18 or 5.2.20 or newer, and deploy applications on supported embedded servlet containers.

---

## Verified Video Walkthrough

- **Video Title**: [Spring4Shell: CVE-2022-22965 TryHackMe WalkThrough](https://www.youtube.com/watch?v=3IETofCVDTk)
- **Direct URL**: https://www.youtube.com/watch?v=3IETofCVDTk
