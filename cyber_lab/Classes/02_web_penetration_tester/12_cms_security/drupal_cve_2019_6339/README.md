# Lab Target: DRUPAL CVE-2019-6339

## Overview
- **Vulnerability**: CVE-2019-6339
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8632
- **Container Name**: `cyberlab_drupal_cve_2019_6339`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8632
[cyberlab_drupal_cve_2019_6339] (vulhub/drupal:8.5.0)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/drupal_cve_2019_6339
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8632/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=XJvpC-p4qKM
