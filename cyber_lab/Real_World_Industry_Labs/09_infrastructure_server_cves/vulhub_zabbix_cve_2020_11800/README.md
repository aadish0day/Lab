# Lab Target: VULHUB_ZABBIX_CVE_2020_11800

## Overview
- **Vulnerability**: Zabbix Server Remote Code Execution Target (CVE-2020-11800)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8793
- **Container Name**: `cyberlab_vulhub_zabbix_cve_2020_11800`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8793
[cyberlab_vulhub_zabbix_cve_2020_11800] (vulhub/zabbix:5.0.0)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulhub_zabbix_cve_2020_11800
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8793/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=bZGDrNmCRWo
