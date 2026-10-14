# GeoServer Unauthenticated JXPath Evaluation RCE (CVE-2024-36401)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **GeoServer Unauthenticated JXPath Evaluation RCE (CVE-2024-36401)** (CVE-2024-36401).

* **Target Directory**: `Real_World_Industry_Labs/02_cloud_k8s_container_escape/geoserver_jxpath_rce`
* **Default Port(s)**: `8193:8080`
* **CLI Shortcut**: `./lab start geoserver-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_geoserver`
* **Upstream Image**: `vulhub/geoserver:2.23.2`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
GeoServer OGC request attribute evaluation flaw utilizing Commons JXPath library for unauthenticated remote code execution.

### Technical Root Cause
GeoServer before versions 2.23.6, 2.24.4, and 2.25.2 evaluates attribute names in OGC request filters (WFS, WMS, WCS) using Apache Commons JXPath. Attackers can execute arbitrary Java code via standard reflection calls in XPath expressions.

---

## Defensive Remediation & Hardening
Upgrade GeoServer to 2.23.6, 2.24.4, 2.25.2 or newer. Remove the `gt-complex` jar if complex features are not required.

---

## Verified Video Walkthrough
* **Video Title**: [CVE-2024-36401: GeoServer RCE Technical Analysis & Remediation](https://www.youtube.com/watch?v=zRnCkII5wCI)
* **Direct URL**: https://www.youtube.com/watch?v=zRnCkII5wCI
