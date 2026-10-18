# Sonatype Nexus 3 Unauthenticated Expression Language Injection RCE (CVE-2019-7238)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Sonatype Nexus 3 Unauthenticated Expression Language Injection RCE (CVE-2019-7238)** (CVE-2019-7238).

- **Target Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/nexus_el_injection_rce`
- **Default Port(s)**: `8206:8081`
- **CLI Shortcut**: `./lab start nexus-el-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_nexus_el`
- **Upstream Image**: `vulhub/nexus:3.14.0`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Sonatype Nexus Repository Manager 3 unauthenticated Java Expression Language injection in preview API.

### Technical Root Cause

Nexus Repository Manager 3 versions before 3.15.0 expose the `/service/extdirect` endpoint without authentication. Specifying the `coreui_Component` service with a malicious JUEL expression in the preview repository parameters evaluates arbitrary Java commands on the host.

---

## Defensive Remediation & Hardening

Upgrade Sonatype Nexus Repository Manager to version 3.15.0 or newer. Enforce strict authentication on extdirect endpoints.

---

## Verified Video Walkthrough

- **Video Title**: [Nexus Intelligence Insights CVE-2019-15753](https://www.youtube.com/watch?v=91nyrDYtmyE)
- **Direct URL**: https://www.youtube.com/watch?v=91nyrDYtmyE
