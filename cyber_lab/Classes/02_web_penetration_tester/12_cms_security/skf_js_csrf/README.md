# Lab Target: SKF_JS_CSRF

## Overview

- **Vulnerability**: OWASP-SKF Node.js Cross-Site Request Forgery Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8758
- **Container Name**: `cyberlab_skf_js_csrf`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8758
[cyberlab_skf_js_csrf] (blabla1337/owasp-skf-lab:js-csrf)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_csrf
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8758/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=q9F_xIi0Xzo
