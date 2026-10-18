# Redis Debian/Ubuntu Package Lua Sandbox Escape Arbitrary Code Execution (CVE-2022-0543)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Redis Debian/Ubuntu Package Lua Sandbox Escape Arbitrary Code Execution (CVE-2022-0543)** (CVE-2022-0543).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/redis_cve_2022_0543`
- **Default Port(s)**: `8232:6379`
- **CLI Shortcut**: `./lab start redis-lua-escape`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_redis_lua`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Redis Debian/Ubuntu packaging vulnerability allowing Lua sandbox escape.

### Technical Root Cause

Debian packaging exposed the Lua package library, allowing EVAL scripts to load shared libraries and call system commands via os.execute.

---

## Defensive Remediation & Hardening

Update Redis packages on Debian/Ubuntu systems to clear the package global table.

---

## Verified Video Walkthrough

- **Video Title**: [How I Got Root Access via Lua Exploit](https://www.youtube.com/watch?v=xNO-wcqFH_g)
- **Direct URL**: https://www.youtube.com/watch?v=xNO-wcqFH_g
