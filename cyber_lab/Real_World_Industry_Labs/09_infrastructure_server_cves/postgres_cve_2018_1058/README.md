# Lab Target: POSTGRES CVE-2018-1058

## Overview
- **Vulnerability**: CVE-2018-1058
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8619
- **Container Name**: `cyberlab_postgres_cve_2018_1058`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8619
[cyberlab_postgres_cve_2018_1058] (vulhub/postgres:9.6.7)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/postgres_cve_2018_1058
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8619/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['aSSISGkplfc', 'vulhub漏洞復現 php/CVE-2018-19518']
