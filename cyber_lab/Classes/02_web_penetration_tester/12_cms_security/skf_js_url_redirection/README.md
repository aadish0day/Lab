# Lab Target: SKF_JS_URL_REDIRECTION

## Overview

- **Vulnerability**: OWASP-SKF Node.js Open URL Redirection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8750
- **Container Name**: `cyberlab_skf_js_url_redirection`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8750
[cyberlab_skf_js_url_redirection] (blabla1337/owasp-skf-lab:js-url-redirection)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_url_redirection
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8750/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=S8GEy4Gvkro
