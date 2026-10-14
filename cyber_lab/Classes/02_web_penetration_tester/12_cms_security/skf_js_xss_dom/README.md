# Lab Target: SKF_JS_XSS_DOM

## Overview
- **Vulnerability**: OWASP-SKF Node.js DOM XSS Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8743
- **Container Name**: `cyberlab_skf_js_xss_dom`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8743
[cyberlab_skf_js_xss_dom] (blabla1337/owasp-skf-lab:js-xss-dom)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_xss_dom
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8743/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=gxID0acwBgc
