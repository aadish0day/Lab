# Lab Target: SKF_JS_OPEN_REDIRECT_HARDER

## Overview
- **Vulnerability**: OWASP-SKF Node.js Hardened Open Redirect Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8755
- **Container Name**: `cyberlab_skf_js_open_redirect_harder`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8755
[cyberlab_skf_js_open_redirect_harder] (blabla1337/owasp-skf-lab:js-open-redirect-harder)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_open_redirect_harder
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8755/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Ju3Wc6S0GhM
