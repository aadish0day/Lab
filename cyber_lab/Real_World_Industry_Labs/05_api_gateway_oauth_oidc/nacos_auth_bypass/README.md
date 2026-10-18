# Alibaba Nacos Dynamic Service Platform Authentication Bypass (CVE-2021-29441)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Alibaba Nacos Dynamic Service Platform Authentication Bypass (CVE-2021-29441)** (CVE-2021-29441).

- **Target Directory**: `Real_World_Industry_Labs/05_api_gateway_oauth_oidc/nacos_auth_bypass`
- **Default Port(s)**: `8207:8848`
- **CLI Shortcut**: `./lab start nacos-auth-bypass`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_nacos`
- **Upstream Image**: `vulhub/nacos:1.4.0`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Alibaba Nacos service discovery and configuration platform user-agent authentication bypass.

### Technical Root Cause

In Alibaba Nacos versions prior to 1.4.1, an internal server-to-server communication filter allows requests bearing a custom `User-Agent: Nacos-Server` header to completely bypass authentication checks on administrative endpoints like `/nacos/v1/auth/users`.

---

## Defensive Remediation & Hardening

Upgrade Nacos to version 1.4.1 or later. Set `nacos.core.auth.enabled=true` and configure explicit authentication tokens.

---

## Verified Video Walkthrough

- **Video Title**: [CAS Quick Tour - Apereo's Central Authentication Service (CAS) Single Sign-On](https://www.youtube.com/watch?v=TZUg4PUfS1M)
- **Direct URL**: https://www.youtube.com/watch?v=TZUg4PUfS1M
