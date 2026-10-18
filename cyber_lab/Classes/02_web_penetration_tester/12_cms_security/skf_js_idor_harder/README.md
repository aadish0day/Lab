# Lab Target: SKF_JS_IDOR_HARDER

## Overview

- **Vulnerability**: OWASP-SKF Node.js Hardened IDOR Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8757
- **Container Name**: `cyberlab_skf_js_idor_harder`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8757
[cyberlab_skf_js_idor_harder] (blabla1337/owasp-skf-lab:js-idor-harder)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_idor_harder
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8757/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=W4MXUnZB2jc
