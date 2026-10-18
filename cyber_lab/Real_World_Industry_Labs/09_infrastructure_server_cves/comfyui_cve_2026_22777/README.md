# Lab Target: COMFYUI CVE-2026-22777

## Overview

- **Vulnerability**: CVE-2026-22777
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8669
- **Container Name**: `cyberlab_comfyui_cve_2026_22777`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8669
[cyberlab_comfyui_cve_2026_22777] (vulhub/comfyui:3.39.1-with-manager)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/comfyui_cve_2026_22777
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8669/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=ncJOuqoMgFM
