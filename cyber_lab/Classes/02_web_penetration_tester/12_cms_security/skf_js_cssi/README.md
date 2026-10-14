# Lab Target: SKF_JS_CSSI

## Overview
- **Vulnerability**: OWASP-SKF Node.js CSS Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8809
- **Container Name**: `cyberlab_skf_js_cssi`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8809
[cyberlab_skf_js_cssi] (blabla1337/owasp-skf-lab:js-cssi)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_cssi
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8809/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=kxtgTiRJ-wg
