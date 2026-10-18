# Apache OFBiz XML-RPC Java Deserialization Remote Code Execution (CVE-2020-9496)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache OFBiz XML-RPC Java Deserialization Remote Code Execution (CVE-2020-9496)** (CVE-2020-9496).

- **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_xmlrpc_deserialization`
- **Default Port(s)**: `8220:8443`
- **CLI Shortcut**: `./lab start ofbiz-xmlrpc-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_ofbiz_9496`
- **Upstream Image**: `vulhub/ofbiz:17.12.01`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache OFBiz XML-RPC request handler deserialization of untrusted XML payloads leading to RCE.

### Technical Root Cause

Apache OFBiz before 17.12.04 exposes the `/webtools/control/xmlrpc` endpoint without authentication. XML-RPC payloads containing serialized Java gadget chains (e.g. Commons Beanutils) are deserialized upon arrival.

---

## Defensive Remediation & Hardening

Upgrade Apache OFBiz to version 17.12.04 or newer. Disable the XML-RPC component if not needed.

---

## Verified Video Walkthrough

- **Video Title**: [Apache ofbiz rce | CVE-2020-9496 PoC](https://www.youtube.com/watch?v=DO93Xc8sGWg)
- **Direct URL**: https://www.youtube.com/watch?v=DO93Xc8sGWg
