# Lab Target: INGRESS-NGINX CVE-2025-1974

## Overview

- **Vulnerability**: CVE-2025-1974
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8671
- **Container Name**: `cyberlab_ingress_nginx_cve_2025_1974`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8671
[cyberlab_ingress_nginx_cve_2025_1974] (vulhub/ingress-nginx:1.9.5)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/ingress_nginx_cve_2025_1974
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8671/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=bJ1hZnqNRZM
