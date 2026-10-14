# Lab Target: IMAGEMAGICK CVE-2022-44268

## Overview
- **Vulnerability**: CVE-2022-44268
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8627
- **Container Name**: `cyberlab_imagemagick_cve_2022_44268`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8627
[cyberlab_imagemagick_cve_2022_44268] (vulhub/imagemagick:7.1.0-49-php)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/imagemagick_cve_2022_44268
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8627/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=3SKkwoMIhK0
