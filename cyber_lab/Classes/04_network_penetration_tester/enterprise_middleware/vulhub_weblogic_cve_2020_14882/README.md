# Lab Target: VULHUB_WEBLOGIC_CVE_2020_14882

## Overview
- **Vulnerability**: Oracle WebLogic Console Authentication Bypass RCE (CVE-2020-14882)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8771
- **Container Name**: `cyberlab_vulhub_weblogic_cve_2020_14882`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8771
[cyberlab_vulhub_weblogic_cve_2020_14882] (vulhub/weblogic:12.2.1.3)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_weblogic_cve_2020_14882
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8771/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=RC30YCI0c4I
