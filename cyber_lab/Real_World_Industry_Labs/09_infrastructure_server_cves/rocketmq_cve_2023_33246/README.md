# Lab Target: ROCKETMQ CVE-2023-33246

## Overview
- **Vulnerability**: CVE-2023-33246
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8617
- **Container Name**: `cyberlab_rocketmq_cve_2023_33246`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8617
[cyberlab_rocketmq_cve_2023_33246] (vulhub/rocketmq:5.1.0)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/rocketmq_cve_2023_33246
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8617/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['aQa9_1FEIAE', 'PostgreSQL: Time-of-check Time-of-use (TOCTOU) race condition (CVE-2024-7348) #shorts #breaking']
