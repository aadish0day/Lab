# SaltStack Salt-Master ClearFuncs Unauthenticated RCE (CVE-2020-11651)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **SaltStack Salt-Master ClearFuncs Unauthenticated RCE (CVE-2020-11651)** (CVE-2020-11651).

- **Target Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/saltstack_clearfuncs_rce`
- **Default Port(s)**: `8208:8000`
- **CLI Shortcut**: `./lab start saltstack-clearfuncs-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_saltstack_clearfuncs`
- **Upstream Image**: `vulhub/saltstack:2019.2.3`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

SaltStack ClearFuncs class unauthenticated method invocation allowing arbitrary minion execution and master file disclosure.

### Technical Root Cause

In SaltStack before 2019.2.4 and 3000 before 3000.2, the `ClearFuncs` class in the salt-master ZeroMQ request server fails to validate caller credentials, allowing remote attackers to invoke `_send_pub()` to broadcast commands to all connected minions.

---

## Defensive Remediation & Hardening

Upgrade SaltStack to versions 2019.2.4, 3000.2, or newer. Restrict access to ZeroMQ ports 4505 and 4506.

---

## Verified Video Walkthrough

- **Video Title**: [Saltstack vulnerability PoC | CVE-2020-16846](https://www.youtube.com/watch?v=5cV9wh2w-O8)
- **Direct URL**: https://www.youtube.com/watch?v=5cV9wh2w-O8
