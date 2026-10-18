# Apache HugeGraph Gremlin Sandbox Filter Bypass RCE (CVE-2024-27348)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache HugeGraph Gremlin Sandbox Filter Bypass RCE (CVE-2024-27348)** (CVE-2024-27348).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/hugegraph_cve_2024_27348`
- **Default Port(s)**: `8242:8080`
- **CLI Shortcut**: `./lab start hugegraph-gremlin-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_hugegraph_gremlin`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache HugeGraph Gremlin sandbox filter bypass command execution.

### Technical Root Cause

HugeGraph Gremlin engine sandbox blacklist was bypassed using Java reflection and ClassLoader manipulation, allowing unauthenticated RCE.

---

## Defensive Remediation & Hardening

Upgrade Apache HugeGraph to version 1.3.0 or later and enforce authentication.

---

## Verified Video Walkthrough

- **Video Title**: [CVE-2024-27348: Apache HugeGraph RCE Technical Analysis & Remediation](https://www.youtube.com/watch?v=Hv8H7ZgNdi4)
- **Direct URL**: https://www.youtube.com/watch?v=Hv8H7ZgNdi4
