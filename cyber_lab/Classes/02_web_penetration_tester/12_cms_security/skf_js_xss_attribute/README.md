# Lab Target: SKF_JS_XSS_ATTRIBUTE

## Overview

- **Vulnerability**: OWASP-SKF Node.js Attribute XSS Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8742
- **Container Name**: `cyberlab_skf_js_xss_attribute`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8742
[cyberlab_skf_js_xss_attribute] (blabla1337/owasp-skf-lab:js-xss-attribute)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_xss_attribute
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8742/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=33VZ7RvMkgM
