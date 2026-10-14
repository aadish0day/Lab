# Lab Target: SKF_JS_RFI

## Overview
- **Vulnerability**: OWASP-SKF Node.js Remote File Inclusion Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8748
- **Container Name**: `cyberlab_skf_js_rfi`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8748
[cyberlab_skf_js_rfi] (blabla1337/owasp-skf-lab:js-rfi)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_rfi
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8748/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=aSSISGkplfc
