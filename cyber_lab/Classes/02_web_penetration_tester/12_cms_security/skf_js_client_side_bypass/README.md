# Lab Target: SKF_JS_CLIENT_SIDE_BYPASS

## Overview
- **Vulnerability**: OWASP-SKF Node.js Client-Side Bypass Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8806
- **Container Name**: `cyberlab_skf_js_client_side_bypass`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8806
[cyberlab_skf_js_client_side_bypass] (blabla1337/owasp-skf-lab:js-client-side-restriction-bypass)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_client_side_bypass
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8806/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=h51jm1o82fI
