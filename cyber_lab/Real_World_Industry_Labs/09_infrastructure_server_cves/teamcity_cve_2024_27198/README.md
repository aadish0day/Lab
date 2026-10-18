# Lab Target: TEAMCITY CVE-2024-27198

## Overview

- **Vulnerability**: CVE-2024-27198
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8604
- **Container Name**: `cyberlab_teamcity_cve_2024_27198`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8604
[cyberlab_teamcity_cve_2024_27198] (vulhub/teamcity:2023.11.3)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/teamcity_cve_2024_27198
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8604/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['XqwbVU-gtng', '#Eko2020 DevSecOps | Madhu Akula: Kubernetes Goat - Vulnerable by Design Kubernetes Environment']
