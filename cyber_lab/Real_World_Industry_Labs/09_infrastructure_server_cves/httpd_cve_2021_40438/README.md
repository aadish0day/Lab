# Lab Target: HTTPD CVE-2021-40438

## Overview
- **Vulnerability**: CVE-2021-40438
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8673
- **Container Name**: `cyberlab_httpd_cve_2021_40438`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8673
[cyberlab_httpd_cve_2021_40438] (vulhub/tomcat:8.5.19)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/httpd_cve_2021_40438
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8673/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=t5FBwq-kudw
