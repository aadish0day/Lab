# Apache Druid JavaScript Remote Code Execution (CVE-2021-25646)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Druid JavaScript Remote Code Execution (CVE-2021-25646)** (CVE-2021-25646).

* **Target Directory**: `Real_World_Industry_Labs/02_cloud_k8s_container_escape/apache_druid_rce`
* **Default Port(s)**: `8183:8888`
* **CLI Shortcut**: `./lab start druid-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_druid`
* **Upstream Image**: `vulhub/apache-druid:0.20.0`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Druid JSON-based ingestion spec JavaScript code evaluation leading to remote code execution.

### Technical Root Cause
Apache Druid versions up to 0.20.0 allow authenticated users (or unauthenticated when auth is disabled) to send malicious JSON-based ingestion specs with embedded JavaScript filters or dimension selectors through the `/druid/indexer/v1/sampler` endpoint.

---

## Defensive Remediation & Hardening
Upgrade Apache Druid to version 0.20.1 or higher. Disable JavaScript ingestion functions by setting `druid.javascript.enabled=false`.

---

## Verified Video Walkthrough
* **Video Title**: [apache druid #rce | CVE-2021-25646](https://www.youtube.com/watch?v=CzgAw2R5OBo)
* **Direct URL**: https://www.youtube.com/watch?v=CzgAw2R5OBo
