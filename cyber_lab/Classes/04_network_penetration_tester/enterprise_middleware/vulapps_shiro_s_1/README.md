# Lab Target: VULAPPS_SHIRO_S_1

## Overview
- **Vulnerability**: Apache Shiro Default Encryption Key Deserialization RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8717
- **Container Name**: `cyberlab_vulapps_shiro_s_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8717
[cyberlab_vulapps_shiro_s_1] (medicean/vulapps:s_shiro_1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_shiro_s_1
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8717/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=v3Dt3Lwb_-0
