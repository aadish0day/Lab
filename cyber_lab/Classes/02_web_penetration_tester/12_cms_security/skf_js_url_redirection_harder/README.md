# Lab Target: SKF_JS_URL_REDIRECTION_HARDER

## Overview
- **Vulnerability**: OWASP-SKF Node.js Filtered URL Redirection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8751
- **Container Name**: `cyberlab_skf_js_url_redirection_harder`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8751
[cyberlab_skf_js_url_redirection_harder] (blabla1337/owasp-skf-lab:js-url-redirection-harder)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_url_redirection_harder
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8751/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=C-Uck0h5L9s
