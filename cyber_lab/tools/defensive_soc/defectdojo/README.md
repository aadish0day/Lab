# Vulnerability Management & Threat Intelligence Lab (DefectDojo)

## Overview

Practice real-world vulnerability management, ingestion of scan reports from Nessus, Acunetix, Qualys, and CVSS severity triage (Obsidian Topic: _Vulnerability Management and Threat Intelligence_).

- **Default Port / Access**: `http://localhost:8098`
- **Primary Web Container**: `cyberlab_defectdojo_server`
- **Shortcut**: `./lab start threat-intel`

---

## Stack Architecture

DefectDojo runs as an official multi-container stack:

- **`defectdojo-django`** (`cyberlab_defectdojo_server`): Core Django application and web interface exposed on host port `8098` (container port `8080`).
- **`postgres`** (`cyberlab_defectdojo_postgres`): PostgreSQL 15 database running on the internal network with volume `defectdojo_postgres`.
- **`redis`** (`cyberlab_defectdojo_redis`): Redis 7 message broker and cache with volume `defectdojo_redis`.
- **`celery-worker`** (`cyberlab_defectdojo_celery_worker`): Asynchronous background ingestion worker handling report parsing, deduplication, and notification workflows.
- **`initializer`** (`cyberlab_defectdojo_initializer`): One-shot bootstrap container that runs database migrations and seeds initial admin credentials and system fixtures.
- **`permissions`** (`cyberlab_defectdojo_permissions`): Volume permission utility ensuring `defectdojo_media` is properly writable by container UID `1001`.

---

## Default Credentials & Authentication

| Field        | Value                   |
| ------------ | ----------------------- |
| **URL**      | `http://localhost:8098` |
| **Username** | `admin`                 |
| **Password** | `admin`                 |

> [!NOTE]
> On first boot, the `initializer` container automatically applies migrations and provisions the superuser account. If custom credentials or generated passwords are used, inspect the initializer logs:
>
> ```bash
> docker logs cyberlab_defectdojo_initializer | grep "Admin password:"
> ```
>
> To reset the admin password manually at any time:
>
> ```bash
> docker compose exec defectdojo-django ./manage.py changepassword admin
> ```

---

## Setup & Practice Instructions

### 1. Launch the Lab

From the repository root:

```bash
./lab start threat-intel
```

Or directly from this directory:

```bash
docker compose up -d
```

### 2. Verify Initialization

DefectDojo migrations take approximately 60–90 seconds on first run:

```bash
# Watch initializer progress
docker compose logs -f initializer

# Verify running services
./lab status
```

### 3. Access Web UI

Open your browser and navigate to `http://localhost:8098` and authenticate with `admin` / `admin`.

### 4. Stop the Lab

```bash
./lab stop threat-intel
# Or:
docker compose down
```

---

## Lab Objectives

1. **Ingest Vulnerability Scans**:
   Export `.nessus`, Nmap XML, or Nikto/Burp XML scans from your Kali / Nessus VM and import them directly into DefectDojo.

2. **Deduplication & Correlation**:
   Watch how DefectDojo maps raw findings to CVE / CWE identifiers and groups duplicate vulnerabilities across scan runs.

3. **CVSS v3.1 Scoring & Remediation SLAs**:
   Assign CVSS metrics, track remediation workflows, and verify false-positive suppression rules.

---

## YouTube Walkthroughs & Solving Guides

- [Cyber Wolf - DefectDojo: Open-Source Vulnerability Management Made Easy](https://www.youtube.com/watch?v=eYX4fktYmzc)
- [Whitespots - How to Work with DefectDojo for DevSecOps](https://www.youtube.com/watch?v=_uFOIf1BUwU)
