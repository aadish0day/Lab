# Lab Target: SKF_JS_PATH_TRAVERSAL

## Overview
- **Vulnerability**: OWASP-SKF Node.js Directory Path Traversal Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8768
- **Container Name**: `cyberlab_skf_js_path_traversal`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8768
[cyberlab_skf_js_path_traversal] (blabla1337/owasp-skf-lab:js-path-traversal)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_path_traversal
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8768/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=B7p8dIB7bFg
