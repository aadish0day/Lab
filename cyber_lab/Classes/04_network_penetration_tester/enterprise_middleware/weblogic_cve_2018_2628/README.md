# Lab Target: WEBLOGIC CVE-2018-2628

## Overview
- **Vulnerability**: CVE-2018-2628
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8582
- **Container Name**: `cyberlab_weblogic_cve_2018_2628`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8582
[cyberlab_weblogic_cve_2018_2628] (vulhub/weblogic:10.3.6.0-2017)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/weblogic_cve_2018_2628
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8582/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['Sj5-lFWqBu0', 'CRITICAL Django SQL Injection (CVE-2025-64459): Patch NOW or Get Hacked!']
