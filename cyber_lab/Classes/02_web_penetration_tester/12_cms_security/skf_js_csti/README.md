# Lab Target: SKF_JS_CSTI

## Overview
- **Vulnerability**: OWASP-SKF Node.js Client-Side Template Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8808
- **Container Name**: `cyberlab_skf_js_csti`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8808
[cyberlab_skf_js_csti] (blabla1337/owasp-skf-lab:js-csti)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_csti
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8808/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=aSSISGkplfc
