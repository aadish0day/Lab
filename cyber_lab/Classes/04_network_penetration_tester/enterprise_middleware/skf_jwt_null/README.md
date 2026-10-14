# Lab Target: SKF_JWT_NULL

## Overview
- **Vulnerability**: OWASP-SKF None Algorithm JWT Bypass Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8710
- **Container Name**: `cyberlab_skf_jwt_null`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8710
[cyberlab_skf_jwt_null] (blabla1337/owasp-skf-lab:jwt-null)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_jwt_null
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8710/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=CxBI2RRg-Mk
