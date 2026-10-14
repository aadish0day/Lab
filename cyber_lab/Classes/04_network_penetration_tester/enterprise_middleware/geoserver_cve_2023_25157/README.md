# Lab Target: GEOSERVER CVE-2023-25157

## Overview
- **Vulnerability**: CVE-2023-25157
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8649
- **Container Name**: `cyberlab_geoserver_cve_2023_25157`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8649
[cyberlab_geoserver_cve_2023_25157] (vulhub/geoserver:2.22.1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/geoserver_cve_2023_25157
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8649/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=xDotz4iOVNQ
