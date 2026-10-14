# Lab Target: SKF_JWT_JWKS_SPOOFING

## Overview
- **Vulnerability**: OWASP-SKF JWKS Endpoint Spoofing Verification Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8853
- **Container Name**: `cyberlab_skf_jwt_jwks_spoofing`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8853
[cyberlab_skf_jwt_jwks_spoofing] (blabla1337/owasp-skf-lab:jwt-jwks-spoofing)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_jwt_jwks_spoofing
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8853/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=bZGDrNmCRWo
