# Lab Target: SKF_JS_NOSQLI

## Overview
- **Vulnerability**: OWASP-SKF Node.js NoSQL Operator Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8782
- **Container Name**: `cyberlab_skf_js_nosqli`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8782
[cyberlab_skf_js_nosqli] (blabla1337/owasp-skf-lab:js-nosqli)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_js_nosqli
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8782/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=1dDvEmlLpWE
