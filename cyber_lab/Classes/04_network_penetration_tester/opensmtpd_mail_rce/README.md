# OpenSMTPD Mail Server Command Injection RCE (CVE-2020-7247)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **OpenSMTPD Mail Server Command Injection RCE (CVE-2020-7247)** (CVE-2020-7247).

* **Target Directory**: `Classes/04_network_penetration_tester/opensmtpd_mail_rce`
* **Default Port(s)**: `8192:25, 2525:25`
* **CLI Shortcut**: `./lab start opensmtpd-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_opensmtpd`
* **Upstream Image**: `vulhub/opensmtpd:6.6.1p1`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
OpenSMTPD MAIL FROM parameter string parsing flaw leading to local command execution as root.

### Technical Root Cause
OpenSMTPD versions prior to 6.6.2p1 fail to properly validate email recipient and sender addresses containing shell metacharacters in the `MAIL FROM` command. When delivering mail locally, the input is passed directly to the system shell.

---

## Defensive Remediation & Hardening
Upgrade OpenSMTPD to version 6.6.2p1 or newer. Enforce strict address format checking.

---

## Verified Video Walkthrough
* **Video Title**: [Review CVE-2020-7247](https://www.youtube.com/watch?v=1j1ORbmeJ7A)
* **Direct URL**: https://www.youtube.com/watch?v=1j1ORbmeJ7A
