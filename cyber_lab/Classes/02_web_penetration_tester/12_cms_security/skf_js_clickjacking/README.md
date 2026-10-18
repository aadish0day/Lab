# Lab Target: SKF_JS_CLICKJACKING

## Overview

- **Vulnerability**: OWASP-SKF Node.js Clickjacking Protection Bypass
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8807
- **Container Name**: `cyberlab_skf_js_clickjacking`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8807
[cyberlab_skf_js_clickjacking] (blabla1337/owasp-skf-lab:js-clickjacking)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_clickjacking
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8807/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jbMuwu7jicI
