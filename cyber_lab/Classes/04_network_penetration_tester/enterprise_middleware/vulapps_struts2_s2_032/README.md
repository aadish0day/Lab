# Lab Target: VULAPPS_STRUTS2_S2_032

## Overview
- **Vulnerability**: Apache Struts2 S2-032 Method Prefix RCE Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8700
- **Container Name**: `cyberlab_vulapps_struts2_s2_032`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8700
[cyberlab_vulapps_struts2_s2_032] (medicean/vulapps:s_struts2_s2-032)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_struts2_s2_032
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8700/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=9UAQ1VzSq8Q
