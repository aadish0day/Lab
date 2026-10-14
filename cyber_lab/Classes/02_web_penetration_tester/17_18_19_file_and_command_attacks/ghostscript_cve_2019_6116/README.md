# Artifex Ghostscript -dSAFER Sandbox Policy Bypass Remote Code Execution (CVE-2019-6116)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Artifex Ghostscript -dSAFER Sandbox Policy Bypass Remote Code Execution (CVE-2019-6116)** (CVE-2019-6116).

* **Target Directory**: `Classes/02_web_penetration_tester/17_18_19_file_and_command_attacks/ghostscript_cve_2019_6116`
* **Default Port(s)**: `8222:8080`
* **CLI Shortcut**: `./lab start ghostscript-policy-bypass`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_ghostscript_6116`
* **Upstream Image**: `vulhub/imagemagick:7.0.8-27-php`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Ghostscript -dSAFER sandbox bypass via object type confusion allowing arbitrary command execution.

### Technical Root Cause
In Artifex Ghostscript before 9.27, PostScript files can override pseudo-operators in `systemdict` to bypass `-dSAFER` protections. Processing malicious PostScript/EPS files via ImageMagick executes arbitrary OS commands.

---

## Defensive Remediation & Hardening
Upgrade Ghostscript to version 9.27 or newer. Disable PostScript delegate handlers in `policy.xml`.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2026-108693: ImageMagick Ghostscript Hijack Explained](https://www.youtube.com/watch?v=eK3V3Linycw)
* **Direct URL**: https://www.youtube.com/watch?v=eK3V3Linycw
