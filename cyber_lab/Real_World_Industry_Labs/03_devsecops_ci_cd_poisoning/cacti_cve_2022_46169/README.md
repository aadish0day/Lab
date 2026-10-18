# Cacti Network Monitoring Remote_Agent Unauthenticated Command Injection RCE (CVE-2022-46169)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Cacti Network Monitoring Remote_Agent Unauthenticated Command Injection RCE (CVE-2022-46169)** (CVE-2022-46169).

- **Target Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/cacti_cve_2022_46169`
- **Default Port(s)**: `8230:80`
- **CLI Shortcut**: `./lab start cacti-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_cacti_rce`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Cacti remote_agent.php header spoofing and poller command injection.

### Technical Root Cause

An unauthenticated attacker can spoof client IP headers to pass authorization in remote_agent.php and inject shell commands via the poller_id parameter.

---

## Defensive Remediation & Hardening

Upgrade Cacti to 1.2.23+ and ensure IP validation does not trust client HTTP headers.

---

## Verified Video Walkthrough

- **Video Title**: [Exploit Walkthrough: CVE-2022-46169 - Authentication Bypass & RCE in Cacti 1.2.22](https://www.youtube.com/watch?v=TUdmvq6FoNk)
- **Direct URL**: https://www.youtube.com/watch?v=TUdmvq6FoNk
