# Lab Target: SKF_JS_CORS

## Overview

- **Vulnerability**: OWASP-SKF Node.js Insecure CORS Configuration Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8759
- **Container Name**: `cyberlab_skf_js_cors`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8759
[cyberlab_skf_js_cors] (blabla1337/owasp-skf-lab:js-cors)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_cors
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8759/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=lDGbCxFVXwQ
