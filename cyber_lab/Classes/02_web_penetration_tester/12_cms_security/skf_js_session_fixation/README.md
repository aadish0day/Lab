# Lab Target: SKF_JS_SESSION_FIXATION

## Overview
- **Vulnerability**: OWASP-SKF Node.js Session Fixation Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8766
- **Container Name**: `cyberlab_skf_js_session_fixation`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8766
[cyberlab_skf_js_session_fixation] (blabla1337/owasp-skf-lab:js-session-fixation)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_session_fixation
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8766/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=QjPFjd8GJWY
