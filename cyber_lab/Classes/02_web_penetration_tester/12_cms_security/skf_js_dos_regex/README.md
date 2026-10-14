# Lab Target: SKF_JS_DOS_REGEX

## Overview
- **Vulnerability**: OWASP-SKF Node.js Regular Expression DoS Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8804
- **Container Name**: `cyberlab_skf_js_dos_regex`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8804
[cyberlab_skf_js_dos_regex] (blabla1337/owasp-skf-lab:js-dos-regex)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_dos_regex
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8804/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=dff4SROag0w
