# Spring Data REST PATCH Request JSON-Patch SpEL Injection RCE (CVE-2017-8046)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Spring Data REST PATCH Request JSON-Patch SpEL Injection RCE (CVE-2017-8046)** (CVE-2017-8046).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/spring_data_rest_rce`
- **Default Port(s)**: `8213:8080`
- **CLI Shortcut**: `./lab start spring-data-rest-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_spring_data_rest`
- **Upstream Image**: `vulhub/spring-rest-data:2.6.6`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Spring Data REST PATCH request path expression evaluated as Spring Expression Language (SpEL).

### Technical Root Cause

In Spring Data REST versions prior to 2.6.9 and 3.0.1, the path attribute in JSON PATCH operations (`application/json-patch+json`) is evaluated as a SpEL expression, allowing attackers to execute arbitrary commands using standard Java runtime calls.

---

## Defensive Remediation & Hardening

Upgrade Spring Data REST to version 2.6.9, 3.0.1, or newer.

---

## Verified Video Walkthrough

- **Video Title**: [Vulhub 復現 spring/CVE-2017-8046 Spring Data REST PATCH SpEL RCE漏洞](https://www.youtube.com/watch?v=6ZuzA333qV8)
- **Direct URL**: https://www.youtube.com/watch?v=6ZuzA333qV8
