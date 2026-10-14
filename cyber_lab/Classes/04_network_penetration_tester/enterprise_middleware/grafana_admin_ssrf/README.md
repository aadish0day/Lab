# Lab Target: GRAFANA ADMIN-SSRF

## Overview
- **Vulnerability**: ADMIN-SSRF
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8642
- **Container Name**: `cyberlab_grafana_admin_ssrf`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8642
[cyberlab_grafana_admin_ssrf] (vulhub/grafana:8.5.4)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/grafana_admin_ssrf
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8642/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=eK3V3Linycw
