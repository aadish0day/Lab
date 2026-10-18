# Adminer Elasticsearch Driver Server-Side Request Forgery (CVE-2021-21311)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Adminer Elasticsearch Driver Server-Side Request Forgery (CVE-2021-21311)** (CVE-2021-21311).

- **Target Directory**: `Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/adminer_ssrf_cve_2021_21311`
- **Default Port(s)**: `8258:8080`
- **CLI Shortcut**: `./lab start adminer-ssrf-bypass`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_adminer_ssrf`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Adminer database management tool Elasticsearch driver SSRF vulnerability.

### Technical Root Cause

Adminer allowed users to connect to arbitrary Elasticsearch server endpoints, initiating HTTP requests to internal networks and cloud metadata services.

---

## Defensive Remediation & Hardening

Upgrade Adminer to version 4.7.9 or higher and block outgoing connections to internal IP ranges.

---

## Verified Video Walkthrough

- **Video Title**: [Adminer - CVE-2021-21311 - SSRF](https://www.youtube.com/watch?v=PHe0jWGXjiI)
- **Direct URL**: https://www.youtube.com/watch?v=PHe0jWGXjiI
