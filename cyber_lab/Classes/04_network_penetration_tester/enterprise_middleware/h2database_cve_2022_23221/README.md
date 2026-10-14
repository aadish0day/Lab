# Lab Target: H2DATABASE CVE-2022-23221

## Overview
- **Vulnerability**: CVE-2022-23221
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8640
- **Container Name**: `cyberlab_h2database_cve_2022_23221`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8640
[cyberlab_h2database_cve_2022_23221] (vulhub/spring-with-h2database:2.0.206)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/h2database_cve_2022_23221
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8640/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Gk3_Q-3R6jc
