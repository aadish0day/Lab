# Lab Target: CMSMS CVE-2021-26120

## Overview
- **Vulnerability**: CVE-2021-26120
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8639
- **Container Name**: `cyberlab_cmsms_cve_2021_26120`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8639
[cyberlab_cmsms_cve_2021_26120] (vulhub/cmsms:2.2.9.1)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/cmsms_cve_2021_26120
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8639/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=ih5R_c16bKc
