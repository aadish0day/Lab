# Lab Target: SKF_JS_OPEN_REDIRECT

## Overview
- **Vulnerability**: OWASP-SKF Node.js Open Redirect Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8754
- **Container Name**: `cyberlab_skf_js_open_redirect`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8754
[cyberlab_skf_js_open_redirect] (blabla1337/owasp-skf-lab:js-open-redirect)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_open_redirect
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8754/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=cPUVsX9qmA8
