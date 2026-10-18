# Apache Airflow Example DAG Celery Task Command Injection RCE (CVE-2020-11978)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache Airflow Example DAG Celery Task Command Injection RCE (CVE-2020-11978)** (CVE-2020-11978).

- **Target Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/airflow_cve_2020_11978`
- **Default Port(s)**: `8227:8080`
- **CLI Shortcut**: `./lab start airflow-dag-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_airflow_dag`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache Airflow Example DAG Celery task parameter command injection.

### Technical Root Cause

The example_trigger_target_dag in Apache Airflow 1.10.10 insecurely formatted user-supplied JSON configuration into a bash execution command, allowing arbitrary command execution.

---

## Defensive Remediation & Hardening

Upgrade Apache Airflow to 1.10.11+ and set load_examples = False in production.

---

## Verified Video Walkthrough

- **Video Title**: [CVE 2026 58076 Apache Airflow RCE](https://www.youtube.com/watch?v=TOLKVejWzPs)
- **Direct URL**: https://www.youtube.com/watch?v=TOLKVejWzPs
