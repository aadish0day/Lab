# Lab Target: SKF_JS_SSRF

## Overview

- **Vulnerability**: OWASP-SKF Node.js Server-Side Request Forgery Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8784
- **Container Name**: `cyberlab_skf_js_ssrf`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8784
[cyberlab_skf_js_ssrf] (blabla1337/owasp-skf-lab:js-ssrf)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_js_ssrf
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8784/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=-bKEWqcyEBY
