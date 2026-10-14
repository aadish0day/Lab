# Lab Target: VULHUB_NGINX_CVE_2013_4547

## Overview
- **Vulnerability**: Nginx File Name Parsing Bypass Target (CVE-2013-4547)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8792
- **Container Name**: `cyberlab_vulhub_nginx_cve_2013_4547`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8792
[cyberlab_vulhub_nginx_cve_2013_4547] (vulhub/nginx:1.4.0)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulhub_nginx_cve_2013_4547
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8792/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=ErWhWBdDwTU
