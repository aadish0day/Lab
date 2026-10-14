# Lab Target: VULAPPS_STRUTS2_S2_DEVMODE

## Overview
- **Vulnerability**: Apache Struts2 DevMode Parameter Execution RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8703
- **Container Name**: `cyberlab_vulapps_struts2_s2_devmode`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8703
[cyberlab_vulapps_struts2_s2_devmode] (medicean/vulapps:s_struts2_s2-devmode)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_struts2_s2_devmode
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8703/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=eWEgUcHPle0
