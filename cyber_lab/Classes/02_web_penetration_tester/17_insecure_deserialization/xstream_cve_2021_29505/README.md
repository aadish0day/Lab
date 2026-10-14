# XStream Polymorphic Unmarshaling Deserialization RCE (CVE-2021-29505)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **XStream Polymorphic Unmarshaling Deserialization RCE (CVE-2021-29505)** (CVE-2021-29505).

* **Target Directory**: `Classes/02_web_penetration_tester/17_insecure_deserialization/xstream_cve_2021_29505`
* **Default Port(s)**: `8202:8080`
* **CLI Shortcut**: `./lab start xstream-deserialization-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_xstream`
* **Upstream Image**: `vulhub/xstream:1.4.16`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
XStream XML unmarshaling vulnerability via javax.naming gadget chains allowing unauthenticated RCE.

### Technical Root Cause
XStream versions prior to 1.4.17 evaluate untrusted XML payloads without an enforced security framework whitelist. An attacker can instantiate `com.sun.corba.se.impl.presentation.rmi.ReflectiveTie` or JNDI references to execute arbitrary commands.

---

## Defensive Remediation & Hardening
Upgrade XStream to version 1.4.17 or later. Configure strict class allowlists using `XStream.setupDefaultSecurity()`.

---

## Verified Video Walkthrough
* **Video Title**: [PoC Exploiting struts2-rest XStream Deserialization with Reverse Shell](https://www.youtube.com/watch?v=IrZOlqio0nw)
* **Direct URL**: https://www.youtube.com/watch?v=IrZOlqio0nw
