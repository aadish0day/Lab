# Fastjson 1.2.47 AutoType Bypass Deserialization RCE

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Fastjson 1.2.47 AutoType Bypass Deserialization RCE** (Fastjson 1.2.47 AutoType Bypass).

* **Target Directory**: `Classes/02_web_penetration_tester/17_insecure_deserialization/fastjson_cve_2019_12086`
* **Default Port(s)**: `8205:8090`
* **CLI Shortcut**: `./lab start fastjson-autotype-bypass`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_fastjson_autotype`
* **Upstream Image**: `vulhub/fastjson:1.2.45`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Fastjson AutoType bypass using java.lang.Class mapping to execute JNDI remote lookups.

### Technical Root Cause
Fastjson 1.2.47 contains an AutoType bypass flaw where sending a JSON payload containing `java.lang.Class` loads an arbitrary class into the internal `TypeUtils.mappings` cache. Subsequent keys deserialize classes like `java.net.URLClassLoader` or `com.sun.rowset.JdbcRowSetImpl` without passing AutoType checks.

---

## Defensive Remediation & Hardening
Upgrade Fastjson to version 1.2.68 or newer, or migrate to modern Jackson/Gson configurations with strict deserialization controls.

---

## Verified Video Walkthrough
* **Video Title**: [Insecure Deserialization Attack Explained](https://www.youtube.com/watch?v=jwzeJU_62IQ)
* **Direct URL**: https://www.youtube.com/watch?v=jwzeJU_62IQ
