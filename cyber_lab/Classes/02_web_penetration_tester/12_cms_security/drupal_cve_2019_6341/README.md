# Lab Target: DRUPAL CVE-2019-6341

## Overview
- **Vulnerability**: CVE-2019-6341
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8631
- **Container Name**: `cyberlab_drupal_cve_2019_6341`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8631
[cyberlab_drupal_cve_2019_6341] (vulhub/drupal:8.5.0)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/drupal_cve_2019_6341
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8631/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=FLsg8Q4GJ3M
