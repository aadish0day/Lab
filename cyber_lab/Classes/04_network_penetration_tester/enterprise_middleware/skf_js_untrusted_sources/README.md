# Lab Target: SKF_JS_UNTRUSTED_SOURCES

## Overview
- **Vulnerability**: OWASP-SKF Node.js Untrusted Source Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8715
- **Container Name**: `cyberlab_skf_js_untrusted_sources`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8715
[cyberlab_skf_js_untrusted_sources] (blabla1337/owasp-skf-lab:js-untrusted-sources-js)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_js_untrusted_sources
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8715/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=FUODIae2d98
