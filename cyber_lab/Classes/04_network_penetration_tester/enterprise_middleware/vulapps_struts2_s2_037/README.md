# Lab Target: VULAPPS_STRUTS2_S2_037

## Overview
- **Vulnerability**: Apache Struts2 S2-037 REST Plugin RCE Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8701
- **Container Name**: `cyberlab_vulapps_struts2_s2_037`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8701
[cyberlab_vulapps_struts2_s2_037] (medicean/vulapps:s_struts2_s2-037)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_struts2_s2_037
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8701/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=0KYDTt5DiNM
