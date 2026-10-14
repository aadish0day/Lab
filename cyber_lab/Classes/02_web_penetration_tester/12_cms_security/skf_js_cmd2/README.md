# Lab Target: SKF_JS_CMD2

## Overview
- **Vulnerability**: OWASP-SKF Node.js Command Injection v2 Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8686
- **Container Name**: `cyberlab_skf_js_cmd2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8686
[cyberlab_skf_js_cmd2] (blabla1337/owasp-skf-lab:js-cmd2)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_cmd2
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8686/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=h51jm1o82fI
