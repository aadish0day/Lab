# Lab Target: VULHUB_POSTGRES_CVE_2019_9193

## Overview

- **Vulnerability**: PostgreSQL COPY FROM PROGRAM Command Execution (CVE-2019-9193)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8781
- **Container Name**: `cyberlab_vulhub_postgres_cve_2019_9193`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8781
[cyberlab_vulhub_postgres_cve_2019_9193] (vulhub/postgres:11.2)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_postgres_cve_2019_9193
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8781/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=vmSTJI3gFSg
