# Lab Target: VULAPPS_DRUPAL_D_1

## Overview
- **Vulnerability**: Drupal Core Vulnerable Practice Environment
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8696
- **Container Name**: `cyberlab_vulapps_drupal_d_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8696
[cyberlab_vulapps_drupal_d_1] (medicean/vulapps:d_drupal_1)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_drupal_d_1
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8696/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=RYzbA72sbv8
