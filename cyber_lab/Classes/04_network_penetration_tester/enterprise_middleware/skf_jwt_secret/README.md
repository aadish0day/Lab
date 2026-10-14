# Lab Target: SKF_JWT_SECRET

## Overview
- **Vulnerability**: OWASP-SKF Weak Secret HMAC JWT Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8712
- **Container Name**: `cyberlab_skf_jwt_secret`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8712
[cyberlab_skf_jwt_secret] (blabla1337/owasp-skf-lab:jwt-secret)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_jwt_secret
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8712/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=MiaEWNruYdI
