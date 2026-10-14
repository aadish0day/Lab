# Eclipse Jetty URI Path Normalization Arbitrary File Read (CVE-2021-28164)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Eclipse Jetty URI Path Normalization Arbitrary File Read (CVE-2021-28164)** (CVE-2021-28164).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/jetty_cve_2021_28164`
* **Default Port(s)**: `8263:8080`
* **CLI Shortcut**: `./lab start jetty-normalize-fileread`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_jetty_28164`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Eclipse Jetty %2e URI normalization protected WEB-INF file disclosure.

### Technical Root Cause
Jetty URL decoding normalized requests containing /%2e/ segments after security constraints were checked, allowing external users to access sensitive protected resources in WEB-INF.

---

## Defensive Remediation & Hardening
Upgrade Eclipse Jetty to 9.4.39, 10.0.2, or 11.0.2+.

---

## Verified Video Walkthrough
* **Video Title**: [CVE 2020 5284 in kraken POC Directory Traversal attack](https://www.youtube.com/watch?v=xelgUVVtNkY)
* **Direct URL**: https://www.youtube.com/watch?v=xelgUVVtNkY
