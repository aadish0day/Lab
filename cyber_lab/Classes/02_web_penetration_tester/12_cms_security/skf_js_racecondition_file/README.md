# Lab Target: SKF_JS_RACECONDITION_FILE

## Overview
- **Vulnerability**: OWASP-SKF Node.js File Write Race Condition Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8747
- **Container Name**: `cyberlab_skf_js_racecondition_file`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8747
[cyberlab_skf_js_racecondition_file] (blabla1337/owasp-skf-lab:js-racecondition-file-write)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_racecondition_file
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8747/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jbMuwu7jicI
