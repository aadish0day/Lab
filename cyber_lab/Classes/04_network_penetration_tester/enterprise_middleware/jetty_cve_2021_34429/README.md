# Eclipse Jetty Unicode %u002e URI Normalization Access Control Bypass (CVE-2021-34429)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Eclipse Jetty Unicode %u002e URI Normalization Access Control Bypass (CVE-2021-34429)** (CVE-2021-34429).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/jetty_cve_2021_34429`
* **Default Port(s)**: `8264:8080`
* **CLI Shortcut**: `./lab start jetty-u002e-bypass`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_jetty_34429`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Eclipse Jetty %u002e and non-standard character encoding filter bypass.

### Technical Root Cause
Incomplete patch for CVE-2021-28164 allowed attackers to use Microsoft-style Unicode escaping (%u002e) or null byte characters to bypass resource protection constraints.

---

## Defensive Remediation & Hardening
Upgrade Eclipse Jetty to versions 9.4.42, 10.0.5, or 11.0.5+.

---

## Verified Video Walkthrough
* **Video Title**: [Log4J - CVE 2021-44228 (Log4Shell) - Exploitation & Mitigation](https://www.youtube.com/watch?v=lJeAgQQaDEw)
* **Direct URL**: https://www.youtube.com/watch?v=lJeAgQQaDEw
