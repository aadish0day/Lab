# Lab Target: SHOWDOC CNVD-2020-26585

## Overview
- **Vulnerability**: CNVD-2020-26585
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8614
- **Container Name**: `cyberlab_showdoc_cnvd_2020_26585`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8614
[cyberlab_showdoc_cnvd_2020_26585] (vulhub/showdoc:2.8.2)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/showdoc_cnvd_2020_26585
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8614/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['_jz5qFWhLcg', 'Broken Access Control | Complete Guide']
