# Lab Target: COMFYUI CVE-2025-67303

## Overview
- **Vulnerability**: CVE-2025-67303
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8674
- **Container Name**: `cyberlab_comfyui_cve_2025_67303`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8674
[cyberlab_comfyui_cve_2025_67303] (vulhub/comfyui:3.37-with-manager)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/comfyui_cve_2025_67303
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8674/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Hx0rqVlsVv0
