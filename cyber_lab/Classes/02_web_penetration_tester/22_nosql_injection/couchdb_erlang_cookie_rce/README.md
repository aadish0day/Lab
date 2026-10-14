# Apache CouchDB Default Erlang Cookie Remote Code Execution (CVE-2022-24706)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache CouchDB Default Erlang Cookie Remote Code Execution (CVE-2022-24706)** (CVE-2022-24706).

* **Target Directory**: `Classes/02_web_penetration_tester/22_nosql_injection/couchdb_erlang_cookie_rce`
* **Default Port(s)**: `8199:5984`
* **CLI Shortcut**: `./lab start couchdb-cookie-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_couchdb_cookie`
* **Upstream Image**: `vulhub/couchdb:3.2.1`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache CouchDB default Erlang distribution port authentication bypass allowing full remote shell access.

### Technical Root Cause
CouchDB installations expose the Erlang Port Mapper Daemon (EPMD) and Erlang distribution port configured with the well-known default cookie `monster`, permitting remote attackers to connect and execute arbitrary OS commands.

---

## Defensive Remediation & Hardening
Upgrade CouchDB to version 3.2.2 or newer. Set a strong random Erlang cookie and bind distribution ports to loopback.

---

## Verified Video Walkthrough
* **Video Title**: [Not every bug is a vulnerability, and doing something dumb is not a CVE](https://www.youtube.com/watch?v=hBaf7ZpG_ZQ)
* **Direct URL**: https://www.youtube.com/watch?v=hBaf7ZpG_ZQ
