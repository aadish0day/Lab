# Lab Target: COLDFUSION CVE-2023-26360

## Overview
- **Vulnerability**: CVE-2023-26360
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8676
- **Container Name**: `cyberlab_coldfusion_cve_2023_26360`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8676
[cyberlab_coldfusion_cve_2023_26360] (vulhub/coldfusion:2018.0.15)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/coldfusion_cve_2023_26360
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8676/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=x0Bk7nqeB4k
