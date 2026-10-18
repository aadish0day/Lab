# Discuz! X3.4 Arbitrary File Deletion to Admin Re-installation RCE

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Discuz! X3.4 Arbitrary File Deletion to Admin Re-installation RCE** (CWE-73).

- **Target Directory**: `Classes/02_web_penetration_tester/12_cms_security/discuz_x34_file_delete`
- **Default Port(s)**: `8239:80`
- **CLI Shortcut**: `./lab start discuz-file-delete`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_discuz_delete`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Discuz! X3.4 arbitrary file deletion allowing removal of install.lock and installer RCE.

### Technical Root Cause

An authenticated user could delete arbitrary system files using path traversal in upload cleanup routines. Removing install.lock allowed re-installing with malicious database parameters.

---

## Defensive Remediation & Hardening

Update Discuz! X3.4 to the patched release and restrict filesystem write/delete permissions.

---

## Verified Video Walkthrough

- **Video Title**: [Dimofinf cms Version 3.0.0 SQL Injection & XSS (Proof)](https://www.youtube.com/watch?v=RC30YCI0c4I)
- **Direct URL**: https://www.youtube.com/watch?v=RC30YCI0c4I
