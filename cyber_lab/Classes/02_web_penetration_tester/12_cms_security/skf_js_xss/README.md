# Lab Target: SKF_JS_XSS

## Overview
- **Vulnerability**: OWASP-SKF Node.js Cross-Site Scripting Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8740
- **Container Name**: `cyberlab_skf_js_xss`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8740
[cyberlab_skf_js_xss] (blabla1337/owasp-skf-lab:js-xss)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_xss
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8740/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jcouSB4Q2wo
