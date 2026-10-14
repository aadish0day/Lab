# Lab Target: VULAPPS_WORDPRESS_W_3

## Overview
- **Vulnerability**: WordPress REST API Content Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8693
- **Container Name**: `cyberlab_vulapps_wordpress_w_3`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8693
[cyberlab_vulapps_wordpress_w_3] (medicean/vulapps:w_wordpress_3)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_wordpress_w_3
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8693/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=lU_fu-B5QtI
