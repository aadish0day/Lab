# Lab Target: SKF_JS_XSS_DOM_2

## Overview

- **Vulnerability**: OWASP-SKF Node.js Advanced DOM XSS Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8744
- **Container Name**: `cyberlab_skf_js_xss_dom_2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8744
[cyberlab_skf_js_xss_dom_2] (blabla1337/owasp-skf-lab:js-xss-dom-2)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_xss_dom_2
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8744/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=dff4SROag0w
