# Lab Target: MONGO-EXPRESS CVE-2019-10758

## Overview
- **Vulnerability**: CVE-2019-10758
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8620
- **Container Name**: `cyberlab_mongo_express_cve_2019_10758`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8620
[cyberlab_mongo_express_cve_2019_10758] (vulhub/mongo-express:0.53.0)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/mongo_express_cve_2019_10758
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8620/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=rrZ3xh4pfm8
