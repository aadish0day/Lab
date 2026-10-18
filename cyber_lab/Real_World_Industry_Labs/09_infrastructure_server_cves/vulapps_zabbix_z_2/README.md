# Lab Target: VULAPPS_ZABBIX_Z_2

## Overview

- **Vulnerability**: Zabbix Server SQL Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8736
- **Container Name**: `cyberlab_vulapps_zabbix_z_2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8736
[cyberlab_vulapps_zabbix_z_2] (medicean/vulapps:z_zabbix_2)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_zabbix_z_2
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8736/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=iR39Kaez_eM
