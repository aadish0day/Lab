# Lab Target: VULAPPS_CMSEASY_C_1

## Overview
- **Vulnerability**: CMSEasy Template Injection RCE Environment
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8698
- **Container Name**: `cyberlab_vulapps_cmseasy_c_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8698
[cyberlab_vulapps_cmseasy_c_1] (medicean/vulapps:c_cmseasy_1)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_cmseasy_c_1
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8698/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=q9F_xIi0Xzo
