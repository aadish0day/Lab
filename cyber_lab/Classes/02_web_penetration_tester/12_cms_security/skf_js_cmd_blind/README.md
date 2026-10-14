# Lab Target: SKF_JS_CMD_BLIND

## Overview
- **Vulnerability**: OWASP-SKF Node.js Blind Command Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8685
- **Container Name**: `cyberlab_skf_js_cmd_blind`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8685
[cyberlab_skf_js_cmd_blind] (blabla1337/owasp-skf-lab:js-cmd-blind)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_cmd_blind
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8685/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=eHawcxE9f_8
