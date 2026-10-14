# Lab Target: APACHE-DRUID CVE-2021-25646

## Overview
- **Vulnerability**: CVE-2021-25646
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8662
- **Container Name**: `cyberlab_apache_druid_cve_2021_25646`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8662
[cyberlab_apache_druid_cve_2021_25646] (vulhub/apache-druid:0.20.0)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/apache_druid_cve_2021_25646
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8662/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=9n90Y6GPmBU
