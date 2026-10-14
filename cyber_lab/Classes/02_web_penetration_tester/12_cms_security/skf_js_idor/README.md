# Lab Target: SKF_JS_IDOR

## Overview
- **Vulnerability**: OWASP-SKF Node.js Insecure Direct Object Reference Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8756
- **Container Name**: `cyberlab_skf_js_idor`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8756
[cyberlab_skf_js_idor] (blabla1337/owasp-skf-lab:js-idor)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_idor
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8756/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=RYzbA72sbv8
