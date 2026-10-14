# Lab Target: DJANGO CVE-2020-9402

## Overview
- **Vulnerability**: CVE-2020-9402
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8621
- **Container Name**: `cyberlab_django_cve_2020_9402`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8621
[cyberlab_django_cve_2020_9402] (vulhub/django:3.0.3)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/django_cve_2020_9402
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8621/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=EexflA75B7A
