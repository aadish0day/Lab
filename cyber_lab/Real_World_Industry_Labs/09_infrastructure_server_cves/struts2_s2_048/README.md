# Lab Target: STRUTS2 S2-048

## Overview
- **Vulnerability**: S2-048
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8612
- **Container Name**: `cyberlab_struts2_s2_048`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8612
[cyberlab_struts2_s2_048] (vulhub/struts2:2.3.32-showcase)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/struts2_s2_048
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8612/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['__65_GFERKs', 'Prototype Pollution Attack Explained']
