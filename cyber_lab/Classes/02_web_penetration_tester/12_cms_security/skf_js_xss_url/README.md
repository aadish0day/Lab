# Lab Target: SKF_JS_XSS_URL

## Overview
- **Vulnerability**: OWASP-SKF Node.js URL XSS Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8741
- **Container Name**: `cyberlab_skf_js_xss_url`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8741
[cyberlab_skf_js_xss_url] (blabla1337/owasp-skf-lab:js-xss-url)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_xss_url
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8741/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jC_aZB__dSE
