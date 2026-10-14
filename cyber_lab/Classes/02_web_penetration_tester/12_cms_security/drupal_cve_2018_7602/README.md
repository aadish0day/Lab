# Lab Target: DRUPAL CVE-2018-7602

## Overview
- **Vulnerability**: CVE-2018-7602
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8633
- **Container Name**: `cyberlab_drupal_cve_2018_7602`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8633
[cyberlab_drupal_cve_2018_7602] (vulhub/drupal:7.57)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/drupal_cve_2018_7602
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8633/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=7qoPDq41xhQ
