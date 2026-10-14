# Lab Target: IMAGEMAGICK CVE-2020-29599

## Overview
- **Vulnerability**: CVE-2020-29599
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8628
- **Container Name**: `cyberlab_imagemagick_cve_2020_29599`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8628
[cyberlab_imagemagick_cve_2020_29599] (vulhub/imagemagick:7.0.10-36)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/imagemagick_cve_2020_29599
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8628/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=uxnhNq8upD8
