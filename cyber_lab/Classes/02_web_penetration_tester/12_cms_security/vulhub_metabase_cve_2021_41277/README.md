# Lab Target: VULHUB_METABASE_CVE_2021_41277

## Overview
- **Vulnerability**: Metabase GeoJSON Arbitrary File Read Target (CVE-2021-41277)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8764
- **Container Name**: `cyberlab_vulhub_metabase_cve_2021_41277`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8764
[cyberlab_vulhub_metabase_cve_2021_41277] (vulhub/metabase:0.40.4)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_metabase_cve_2021_41277
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8764/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=X4eRbHgRawI
