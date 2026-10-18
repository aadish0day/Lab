# Lab Target: SKF_JS_CSP

## Overview

- **Vulnerability**: OWASP-SKF Node.js Content Security Policy Bypass Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8810
- **Container Name**: `cyberlab_skf_js_csp`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8810
[cyberlab_skf_js_csp] (blabla1337/owasp-skf-lab:js-csp)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_csp
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8810/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=S8GEy4Gvkro
