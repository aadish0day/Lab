# Apache Airflow Session Cookie Default Secret Key Authentication Bypass (CVE-2020-17526)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache Airflow Session Cookie Default Secret Key Authentication Bypass (CVE-2020-17526)** (CVE-2020-17526).

- **Target Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/airflow_cve_2020_17526`
- **Default Port(s)**: `8228:8080`
- **CLI Shortcut**: `./lab start airflow-cookie-bypass`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_airflow_cookie`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache Airflow default session signing key administrative cookie forgery.

### Technical Root Cause

Apache Airflow installations defaulted to static signing keys, allowing attackers to forge signed Flask cookies and gain administrative web privileges without credentials.

---

## Defensive Remediation & Hardening

Generate a cryptographically secure random secret key in airflow.cfg and upgrade to 1.10.14+.

---

## Verified Video Walkthrough

- **Video Title**: [Improving Spark Observability and Separation of Concerns in Apache Airflow](https://www.youtube.com/watch?v=DWBkMjcbWXA)
- **Direct URL**: https://www.youtube.com/watch?v=DWBkMjcbWXA
