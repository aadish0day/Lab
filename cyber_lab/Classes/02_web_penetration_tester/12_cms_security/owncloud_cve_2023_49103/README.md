# ownCloud graphapi phpinfo Admin Credentials & Secret Leak (CVE-2023-49103)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **ownCloud graphapi phpinfo Admin Credentials & Secret Leak (CVE-2023-49103)** (CVE-2023-49103).

- **Target Directory**: `Classes/02_web_penetration_tester/12_cms_security/owncloud_cve_2023_49103`
- **Default Port(s)**: `8266:8080`
- **CLI Shortcut**: `./lab start owncloud-graphapi-leak`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_owncloud_leak`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

ownCloud graphapi app unauthenticated phpinfo disclosure leaking environment variables.

### Technical Root Cause

The graphapi application in ownCloud included an unprotected vendor test URL exposing phpinfo(), which leaked server environment variables, mail credentials, and object store secrets.

---

## Defensive Remediation & Hardening

Remove the graphapi application test endpoint, upgrade ownCloud, and rotate exposed credentials.

---

## Verified Video Walkthrough

- **Video Title**: [Hacking pills #42: CVE-2023-49103 ownCloud critical information disclosure](https://www.youtube.com/watch?v=ST1glAWane0)
- **Direct URL**: https://www.youtube.com/watch?v=ST1glAWane0
