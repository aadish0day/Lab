# Lab Target: SKF_JS_CMD4

## Overview
- **Vulnerability**: OWASP-SKF Node.js Command Injection v4 Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8687
- **Container Name**: `cyberlab_skf_js_cmd4`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8687
[cyberlab_skf_js_cmd4] (blabla1337/owasp-skf-lab:js-cmd4)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_cmd4
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8687/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jbMuwu7jicI
