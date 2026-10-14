# SaltStack salt-api Unauthenticated Shell Command Injection (CVE-2020-16846)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **SaltStack salt-api Unauthenticated Shell Command Injection (CVE-2020-16846)** (CVE-2020-16846).

* **Target Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/saltstack_unauth_rce`
* **Default Port(s)**: `8190:8000, 4505:4505, 4506:4506`
* **CLI Shortcut**: `./lab start saltstack-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_saltstack`
* **Upstream Image**: `vulhub/saltstack:3002`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
SaltStack salt-api unauthenticated shell command injection via SSH client parameter handling.

### Technical Root Cause
In SaltStack before 3002.1, the `salt-api` component provides an SSH execution mechanism where shell metacharacters in HTTP parameters are passed to `subprocess.Popen` with `shell=True` without sanitization.

---

## Defensive Remediation & Hardening
Upgrade SaltStack to version 3002.1 or newer. Do not expose salt-api to untrusted networks.

---

## Verified Video Walkthrough
* **Video Title**: [Saltstack vulnerability PoC | CVE-2020-16846](https://www.youtube.com/watch?v=5cV9wh2w-O8)
* **Direct URL**: https://www.youtube.com/watch?v=5cV9wh2w-O8
