# Lab Target: HTTPD SSI-RCE

## Overview
- **Vulnerability**: SSI-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8672
- **Container Name**: `cyberlab_httpd_ssi_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8672
[cyberlab_httpd_ssi_rce] (vulhub/php:7.4.33-apache)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/httpd_ssi_rce
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8672/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=7jXCBgmOG-M
