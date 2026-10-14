# Lab Target: SKF_JS_LFI_3

## Overview
- **Vulnerability**: OWASP-SKF Node.js Advanced Path Traversal Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8802
- **Container Name**: `cyberlab_skf_js_lfi_3`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8802
[cyberlab_skf_js_lfi_3] (blabla1337/owasp-skf-lab:js-lfi-3)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_lfi_3
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8802/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=33VZ7RvMkgM
