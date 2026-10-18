# Lab Target: SKF_JS_URL_REDIRECTION_HARDER2

## Overview

- **Vulnerability**: OWASP-SKF Node.js Advanced Filtered URL Redirection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8752
- **Container Name**: `cyberlab_skf_js_url_redirection_harder2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8752
[cyberlab_skf_js_url_redirection_harder2] (blabla1337/owasp-skf-lab:js-url-redirection-harder2)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_url_redirection_harder2
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8752/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=zneRNme9h3U
