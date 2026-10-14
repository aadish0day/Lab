# Adminer Server-Side Request & Arbitrary File Read (CVE-2021-43008)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Adminer Server-Side Request & Arbitrary File Read (CVE-2021-43008)** (CVE-2021-43008).

* **Target Directory**: `Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/adminer_arbitrary_file_read`
* **Default Port(s)**: `8189:80`
* **CLI Shortcut**: `./lab start adminer-ssrf`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_adminer`
* **Upstream Image**: `vulhub/adminer:4.6.2`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Adminer database management tool arbitrary file read via server connection and LOAD DATA LOCAL INFILE.

### Technical Root Cause
Adminer 4.6.2 connects to arbitrary remote MySQL servers specified by the client. An attacker-controlled rogue MySQL server can respond to the connection with a `LOAD DATA LOCAL INFILE` request, causing Adminer to transmit local server files.

---

## Defensive Remediation & Hardening
Upgrade Adminer to version 4.8.1 or later. Restrict database connectivity to localhost.

---

## Verified Video Walkthrough
* **Video Title**: [Arbitrary File Read... As a Service](https://www.youtube.com/watch?v=4teLzdM26l4)
* **Direct URL**: https://www.youtube.com/watch?v=4teLzdM26l4
