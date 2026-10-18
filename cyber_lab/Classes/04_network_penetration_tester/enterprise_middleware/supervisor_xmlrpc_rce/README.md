# Supervisor XML-RPC Arbitrary Code Execution (CVE-2017-11610)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Supervisor XML-RPC Arbitrary Code Execution (CVE-2017-11610)** (CVE-2017-11610).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/supervisor_xmlrpc_rce`
- **Default Port(s)**: `8191:9001`
- **CLI Shortcut**: `./lab start supervisor-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_supervisor`
- **Upstream Image**: `vulhub/supervisor:3.3.2`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Supervisor process management daemon XML-RPC server method traversal leading to arbitrary command execution.

### Technical Root Cause

Supervisor versions 3.0a1 through 3.3.2 contain an XML-RPC interface where method names are resolved dynamically. Attackers can call `supervisor.supervisord.options.execve` or related Python namespace methods to run arbitrary system binaries.

---

## Defensive Remediation & Hardening

Upgrade Supervisor to version 3.3.3 or newer. Require authentication and bind XML-RPC only to loopback or UNIX domain sockets.

---

## Verified Video Walkthrough

- **Video Title**: [CVE-2017-11610](https://www.youtube.com/watch?v=hJ5NPVaV0U0)
- **Direct URL**: https://www.youtube.com/watch?v=hJ5NPVaV0U0
