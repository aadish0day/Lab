# Lab Target: SKF_JS_RTLO

## Overview
- **Vulnerability**: OWASP-SKF Node.js Right-to-Left Override Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8753
- **Container Name**: `cyberlab_skf_js_rtlo`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8753
[cyberlab_skf_js_rtlo] (blabla1337/owasp-skf-lab:js-rtlo)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_rtlo
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8753/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=lU_fu-B5QtI
