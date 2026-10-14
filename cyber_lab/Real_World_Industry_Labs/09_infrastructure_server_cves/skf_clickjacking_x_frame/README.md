# Lab Target: SKF_CLICKJACKING_X_FRAME

## Overview
- **Vulnerability**: OWASP-SKF X-Frame-Options Header Clickjacking Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8859
- **Container Name**: `cyberlab_skf_clickjacking_x_frame`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8859
[cyberlab_skf_clickjacking_x_frame] (blabla1337/owasp-skf-lab:clickjacking-x-frame-options)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_clickjacking_x_frame
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8859/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=CuR2BXCE0LY
