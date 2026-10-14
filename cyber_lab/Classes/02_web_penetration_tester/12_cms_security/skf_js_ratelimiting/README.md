# Lab Target: SKF_JS_RATELIMITING

## Overview
- **Vulnerability**: OWASP-SKF Node.js Rate Limiting Bypass Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8745
- **Container Name**: `cyberlab_skf_js_ratelimiting`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8745
[cyberlab_skf_js_ratelimiting] (blabla1337/owasp-skf-lab:js-ratelimiting)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_ratelimiting
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8745/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=eHawcxE9f_8
