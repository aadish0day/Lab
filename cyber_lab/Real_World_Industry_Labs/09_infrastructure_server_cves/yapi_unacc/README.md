# Lab Target: YAPI UNACC

## Overview
- **Vulnerability**: UNACC
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8600
- **Container Name**: `cyberlab_yapi_unacc`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8600
[cyberlab_yapi_unacc] (mongo:5.0.6)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/yapi_unacc
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8600/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['X4eRbHgRawI', 'Web Application Ethical Hacking - Penetration Testing Course for Beginners']
