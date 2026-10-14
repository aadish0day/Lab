# Apache APISIX Dashboard Unauthenticated API Access & Dropper RCE (CVE-2021-45232)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache APISIX Dashboard Unauthenticated API Access & Dropper RCE (CVE-2021-45232)** (CVE-2021-45232).

* **Target Directory**: `Real_World_Industry_Labs/05_api_gateway_oauth_oidc/apisix_cve_2021_45232`
* **Default Port(s)**: `8225:9000, 8226:9080`
* **CLI Shortcut**: `./lab start apisix-dashboard-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_apisix_dashboard`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache APISIX Dashboard unauthenticated API access and dropper code execution.

### Technical Root Cause
Apache APISIX Dashboard versions prior to 2.10.1 allowed unauthenticated remote attackers to invoke internal management endpoints via URI filter bypasses, enabling arbitrary route creation and script injection.

---

## Defensive Remediation & Hardening
Upgrade Apache APISIX Dashboard to version 2.10.1 or higher and restrict administrative interfaces.

---

## Verified Video Walkthrough
* **Video Title**: [Apache APISIX Dashboard | Remote Code Execution | Exploit | POC | CVE-2021-45232](https://www.youtube.com/watch?v=FOC2qDbxRwM)
* **Direct URL**: https://www.youtube.com/watch?v=FOC2qDbxRwM
