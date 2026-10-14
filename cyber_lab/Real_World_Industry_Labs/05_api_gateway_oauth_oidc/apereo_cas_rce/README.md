# Apereo CAS Java Deserialization Remote Code Execution (4.1-rce)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apereo CAS Java Deserialization Remote Code Execution (4.1-rce)** (Apereo CAS 4.1.x).

* **Target Directory**: `Real_World_Industry_Labs/05_api_gateway_oauth_oidc/apereo_cas_rce`
* **Default Port(s)**: `8186:8080`
* **CLI Shortcut**: `./lab start apereo-cas-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_apereo_cas`
* **Upstream Image**: `vulhub/apereo-cas:4.1.5`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apereo CAS Single Sign-On server Java object deserialization flaw in execution state parameter.

### Technical Root Cause
Apereo CAS 4.1.x utilizes Apache Commons Collections and deserializes the `execution` request parameter without cryptographic verification when evaluating Spring Web Flow states, enabling CommonsCollections gadget chain execution.

---

## Defensive Remediation & Hardening
Upgrade to Apereo CAS 4.2.0 or newer. Configure encrypted and signed execution tokens.

---

## Verified Video Walkthrough
* **Video Title**: [CAS Quick Tour - Apereo's Central Authentication Service (CAS) Single Sign-On](https://www.youtube.com/watch?v=TZUg4PUfS1M)
* **Direct URL**: https://www.youtube.com/watch?v=TZUg4PUfS1M
