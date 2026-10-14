# Lab Target: VULAPPS_ZABBIX_Z_1

## Overview
- **Vulnerability**: Zabbix Server Command Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8735
- **Container Name**: `cyberlab_vulapps_zabbix_z_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8735
[cyberlab_vulapps_zabbix_z_1] (medicean/vulapps:z_zabbix_1)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_zabbix_z_1
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8735/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=-dc_vLdYEtA
