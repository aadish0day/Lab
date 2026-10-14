# Lab Target: SKF_JS_SSTI

## Overview
- **Vulnerability**: OWASP-SKF Node.js Server-Side Template Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8799
- **Container Name**: `cyberlab_skf_js_ssti`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8799
[cyberlab_skf_js_ssti] (blabla1337/owasp-skf-lab:js-ssti)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_js_ssti
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8799/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=CuR2BXCE0LY
