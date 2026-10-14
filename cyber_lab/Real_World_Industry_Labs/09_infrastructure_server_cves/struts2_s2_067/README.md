# Lab Target: STRUTS2 S2-067

## Overview
- **Vulnerability**: S2-067
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8606
- **Container Name**: `cyberlab_struts2_s2_067`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8606
[cyberlab_struts2_s2_067] (vulhub/struts2:s2-067)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/struts2_s2_067
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8606/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['YO8rsCMVUyY', '[A1] Hijacking a Session - WebGoat']
