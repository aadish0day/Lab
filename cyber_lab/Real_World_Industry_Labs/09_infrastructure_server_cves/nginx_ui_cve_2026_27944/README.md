# Lab Target: NGINX-UI CVE-2026-27944

## Overview

- **Vulnerability**: CVE-2026-27944
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8670
- **Container Name**: `cyberlab_nginx_ui_cve_2026_27944`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8670
[cyberlab_nginx_ui_cve_2026_27944] (vulhub/nginx-ui:2.3.2)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/nginx_ui_cve_2026_27944
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8670/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=HRRTrnRgMjs
