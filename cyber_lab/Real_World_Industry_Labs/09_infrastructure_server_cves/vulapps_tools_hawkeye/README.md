# Lab Target: VULAPPS_TOOLS_HAWKEYE

## Overview
- **Vulnerability**: Hawkeye Source Code Security Monitor Practice Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8795
- **Container Name**: `cyberlab_vulapps_tools_hawkeye`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8795
[cyberlab_vulapps_tools_hawkeye] (medicean/vulapps:tools_hawkeye)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_tools_hawkeye
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8795/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=-dc_vLdYEtA
