# Lab Target: COLDFUSION CVE-2023-29300

## Overview
- **Vulnerability**: CVE-2023-29300
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8675
- **Container Name**: `cyberlab_coldfusion_cve_2023_29300`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8675
[cyberlab_coldfusion_cve_2023_29300] (vulhub/coldfusion:2018.0.15)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/coldfusion_cve_2023_29300
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8675/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=DhnYtHPeu_4
