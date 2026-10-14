# Lab Target: SKF_JS_JWT_WEAK_KEY

## Overview
- **Vulnerability**: OWASP-SKF Node.js JWT Brute Force Weak Key Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8787
- **Container Name**: `cyberlab_skf_js_jwt_weak_key`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8787
[cyberlab_skf_js_jwt_weak_key] (blabla1337/owasp-skf-lab:js-jwt-weak-key)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_js_jwt_weak_key
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8787/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=vwbUSHUYZnc
