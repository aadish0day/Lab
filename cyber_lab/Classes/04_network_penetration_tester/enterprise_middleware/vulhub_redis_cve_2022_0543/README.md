# Lab Target: VULHUB_REDIS_CVE_2022_0543

## Overview
- **Vulnerability**: Redis Lua Sandbox Escape RCE Target (CVE-2022-0543)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8780
- **Container Name**: `cyberlab_vulhub_redis_cve_2022_0543`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8780
[cyberlab_vulhub_redis_cve_2022_0543] (vulhub/redis:6.2.6)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_redis_cve_2022_0543
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8780/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=F8K99Sn_dsM
