# Lab Target: SKF_JWT_NONE_ALG

## Overview
- **Vulnerability**: OWASP-SKF None Algorithm JWT Signature Bypass
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8851
- **Container Name**: `cyberlab_skf_jwt_none_alg`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8851
[cyberlab_skf_jwt_none_alg] (blabla1337/owasp-skf-lab:jwt-none-algorithm)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_jwt_none_alg
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8851/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=0CFWHjc4B-I
