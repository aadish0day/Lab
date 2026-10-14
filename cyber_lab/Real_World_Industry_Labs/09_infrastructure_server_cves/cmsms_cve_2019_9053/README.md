# Lab Target: CMSMS CVE-2019-9053

## Overview
- **Vulnerability**: CVE-2019-9053
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8678
- **Container Name**: `cyberlab_cmsms_cve_2019_9053`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8678
[cyberlab_cmsms_cve_2019_9053] (vulhub/cmsms:2.2.9.1)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/cmsms_cve_2019_9053
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8678/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=NPwnzH-5udI
