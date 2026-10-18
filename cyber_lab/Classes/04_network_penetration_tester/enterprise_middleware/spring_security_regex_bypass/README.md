# Spring Security RegexRequestMatcher Authorization Bypass (CVE-2022-22978)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Spring Security RegexRequestMatcher Authorization Bypass (CVE-2022-22978)** (CVE-2022-22978).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/spring_security_regex_bypass`
- **Default Port(s)**: `8214:8080`
- **CLI Shortcut**: `./lab start spring-regex-bypass`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_spring_regex`
- **Upstream Image**: `vulhub/spring-security:5.6.3`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Spring Security RegexRequestMatcher newline bypass allowing access to restricted administrative endpoints.

### Technical Root Cause

Spring Security versions 5.5.6 and 5.6.3 using `RegexRequestMatcher` are vulnerable to authorization bypass when matching URL patterns, as regex matching does not account for newline characters (`%0a` or `%0d`) by default, permitting unauthorized endpoint access.

---

## Defensive Remediation & Hardening

Upgrade Spring Security to version 5.5.7, 5.6.4, or later. Prefer `AntPathRequestMatcher` over regex patterns.

---

## Verified Video Walkthrough

- **Video Title**: [[Eng] EP18 - FortiGate Auth Bypass and Credential Stealer (CVE-2019-6693/CVE-2022-40684)](https://www.youtube.com/watch?v=nApIMIx0TyY)
- **Direct URL**: https://www.youtube.com/watch?v=nApIMIx0TyY
