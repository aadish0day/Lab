# Drupalgeddon 3 Forms API Ajax Render Array Property Injection RCE (CVE-2018-7602)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Drupalgeddon 3 Forms API Ajax Render Array Property Injection RCE (CVE-2018-7602)** (CVE-2018-7602).

* **Target Directory**: `Classes/02_web_penetration_tester/12_cms_security/drupalgeddon3_cve_2018_7602`
* **Default Port(s)**: `8233:80`
* **CLI Shortcut**: `./lab start drupalgeddon3`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_drupalgeddon3`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Drupalgeddon 3 authenticated Forms API render array execution.

### Technical Root Cause
Incomplete fix for CVE-2018-7600 allowed authenticated attackers with node edit/delete permissions to inject render array properties into Ajax form destinations.

---

## Defensive Remediation & Hardening
Upgrade Drupal to 7.59 or 8.5.3+.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2018-7600 : Drupal Drupalgeddon 2 Forms API Property Injection](https://www.youtube.com/watch?v=v3Dt3Lwb_-0)
* **Direct URL**: https://www.youtube.com/watch?v=v3Dt3Lwb_-0
