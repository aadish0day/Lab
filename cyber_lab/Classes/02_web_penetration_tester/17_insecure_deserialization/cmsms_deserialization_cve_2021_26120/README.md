# CMS Made Simple PHP Object Injection & Deserialization RCE (CVE-2021-26120)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **CMS Made Simple PHP Object Injection & Deserialization RCE (CVE-2021-26120)** (CVE-2021-26120).

* **Target Directory**: `Classes/02_web_penetration_tester/17_insecure_deserialization/cmsms_deserialization_cve_2021_26120`
* **Default Port(s)**: `8260:80`
* **CLI Shortcut**: `./lab start cmsms-object-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_cmsms_obj`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
CMS Made Simple admin console PHP unserialize object injection RCE.

### Technical Root Cause
An authenticated administrator could trigger PHP object injection via untrusted serialized data processed in site preferences, achieving code execution via POP chains.

---

## Defensive Remediation & Hardening
Upgrade CMS Made Simple to version 2.2.15 or later.

---

## Verified Video Walkthrough
* **Video Title**: [CMS Made Simple Tutorial 01- Installation](https://www.youtube.com/watch?v=uxnhNq8upD8)
* **Direct URL**: https://www.youtube.com/watch?v=uxnhNq8upD8
