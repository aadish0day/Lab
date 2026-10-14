# Lab Target: STRUTS2 S2-061

## Overview
- **Vulnerability**: S2-061
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8608
- **Container Name**: `cyberlab_struts2_s2_061`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8608
[cyberlab_struts2_s2_061] (vulhub/struts2:2.5.25)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/struts2_s2_061
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8608/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['ZPDEnY7ttpM', 'Host #ctf  with #ctfd in Google Cloud Platform - Part I | Complete Setup Guide']
