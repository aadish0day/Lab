# Lab Target: SKF_JS_RACECONDITION

## Overview
- **Vulnerability**: OWASP-SKF Node.js Concurrency Race Condition Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8746
- **Container Name**: `cyberlab_skf_js_racecondition`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8746
[cyberlab_skf_js_racecondition] (blabla1337/owasp-skf-lab:js-racecondition)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_racecondition
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8746/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=h51jm1o82fI
