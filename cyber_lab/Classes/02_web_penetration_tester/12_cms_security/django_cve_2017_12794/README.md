# Lab Target: DJANGO CVE-2017-12794

## Overview
- **Vulnerability**: CVE-2017-12794
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8622
- **Container Name**: `cyberlab_django_cve_2017_12794`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8622
[cyberlab_django_cve_2017_12794] (vulhub/django:1.11.4)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/django_cve_2017_12794
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8622/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=CaFo83TlpPM
