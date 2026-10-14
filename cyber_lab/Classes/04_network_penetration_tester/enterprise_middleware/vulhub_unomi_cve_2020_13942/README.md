# Lab Target: VULHUB_UNOMI_CVE_2020_13942

## Overview
- **Vulnerability**: Apache Unomi OGNL MVEL Remote Code Execution (CVE-2020-13942)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8775
- **Container Name**: `cyberlab_vulhub_unomi_cve_2020_13942`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8775
[cyberlab_vulhub_unomi_cve_2020_13942] (vulhub/unomi:1.5.1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_unomi_cve_2020_13942
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8775/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=FUODIae2d98
