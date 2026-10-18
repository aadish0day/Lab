# Lab Target: SKF_JS_CONTENT_TYPE

## Overview

- **Vulnerability**: OWASP-SKF Node.js Content-Type Validation Bypass Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8805
- **Container Name**: `cyberlab_skf_js_content_type`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8805
[cyberlab_skf_js_content_type] (blabla1337/owasp-skf-lab:js-content-type)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_content_type
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8805/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=eHawcxE9f_8
