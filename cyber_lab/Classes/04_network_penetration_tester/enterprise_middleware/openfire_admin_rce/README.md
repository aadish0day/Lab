# Openfire Admin Console Path Traversal & Plugin RCE (CVE-2023-32315)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Openfire Admin Console Path Traversal & Plugin RCE (CVE-2023-32315)** (CVE-2023-32315).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/openfire_admin_rce`
* **Default Port(s)**: `8185:9090`
* **CLI Shortcut**: `./lab start openfire-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_openfire`
* **Upstream Image**: `vulhub/openfire:4.7.4`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Openfire path traversal in the web administration console leading to unauthenticated administrative access and plugin upload RCE.

### Technical Root Cause
Openfire admin console fails to sanitize URI paths containing `../`, permitting unauthorized users to bypass `AuthCheckFilter` and access internal administrative pages like `setup/setup-s.jsp` and subsequently upload a custom Openfire plugin.

---

## Defensive Remediation & Hardening
Upgrade Openfire to versions 4.7.5, 4.8.0, or newer. Restrict access to administrative port 9090.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2023-32315 Openfire admin console path traversal exploit demo](https://www.youtube.com/watch?v=Sr7QEHl7rpU)
* **Direct URL**: https://www.youtube.com/watch?v=Sr7QEHl7rpU
