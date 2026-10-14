# Lab Target: SKF_XSS_STORED

## Overview
- **Vulnerability**: OWASP-SKF Stored Cross-Site Scripting Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8837
- **Container Name**: `cyberlab_skf_xss_stored`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8837
[cyberlab_skf_xss_stored] (blabla1337/owasp-skf-lab:xss-stored)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_xss_stored
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8837/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=v3Dt3Lwb_-0
