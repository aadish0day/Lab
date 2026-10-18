# Grafana Directory Traversal Arbitrary File Read (CVE-2021-43798)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Grafana Directory Traversal Arbitrary File Read (CVE-2021-43798)** (CVE-2021-43798).

- **Target Directory**: `Real_World_Industry_Labs/02_cloud_k8s_container_escape/grafana_cve_2021_43798`
- **Default Port(s)**: `8182:3000`
- **CLI Shortcut**: `./lab start grafana-traversal`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_grafana`
- **Upstream Image**: `vulhub/grafana:8.2.6`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Grafana unauthenticated directory traversal allowing arbitrary local file reads via installed plugin assets endpoint.

### Technical Root Cause

Grafana versions 8.0.0-beta1 through 8.3.0 fail to properly sanitize request paths within the `/public/plugins/<plugin-id>/` HTTP handler. Attackers can provide traversal sequences (`../../../../..`) to read arbitrary files such as `/etc/passwd` or `/var/lib/grafana/grafana.db`.

---

## Defensive Remediation & Hardening

Upgrade Grafana to version 8.0.7, 8.1.8, 8.2.7, 8.3.1 or later. Ensure web application firewalls block directory traversal sequences.

---

## Verified Video Walkthrough

- **Video Title**: [Exploiting Grafana Directory Traversal and Arbitrary File Read (CVE-2021-43798)](https://www.youtube.com/watch?v=vu1kbdujHTo)
- **Direct URL**: https://www.youtube.com/watch?v=vu1kbdujHTo
