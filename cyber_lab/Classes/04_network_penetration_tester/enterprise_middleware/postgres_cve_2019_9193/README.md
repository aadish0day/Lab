# PostgreSQL COPY FROM PROGRAM Command Execution RCE (CVE-2019-9193)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **PostgreSQL COPY FROM PROGRAM Command Execution RCE (CVE-2019-9193)** (CVE-2019-9193).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/postgres_cve_2019_9193`
* **Default Port(s)**: `8246:5432`
* **CLI Shortcut**: `./lab start postgres-copy-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_postgres_copy`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
PostgreSQL authenticated superuser COPY FROM PROGRAM shell command execution.

### Technical Root Cause
PostgreSQL allows superusers and members of pg_execute_server_program to execute arbitrary OS commands on the database server via COPY ... FROM PROGRAM.

---

## Defensive Remediation & Hardening
Restrict superuser privileges and avoid granting untrusted accounts server program execution roles.

---

## Verified Video Walkthrough
* **Video Title**: [PostgreSQL: Time-of-check Time-of-use (TOCTOU) race condition (CVE-2024-7348) #shorts #breaking](https://www.youtube.com/watch?v=aQa9_1FEIAE)
* **Direct URL**: https://www.youtube.com/watch?v=aQa9_1FEIAE
