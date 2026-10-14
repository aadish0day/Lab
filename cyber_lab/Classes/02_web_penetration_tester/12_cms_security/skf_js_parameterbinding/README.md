# Lab Target: SKF_JS_PARAMETERBINDING

## Overview
- **Vulnerability**: OWASP-SKF Node.js Mass Parameter Binding Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8749
- **Container Name**: `cyberlab_skf_js_parameterbinding`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8749
[cyberlab_skf_js_parameterbinding] (blabla1337/owasp-skf-lab:js-parameterbinding)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_parameterbinding
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8749/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=kxtgTiRJ-wg
