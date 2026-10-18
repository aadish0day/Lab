# Lab Target: SKF_JS_SQLI

## Overview

- **Vulnerability**: OWASP-SKF Node.js SQL Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8783
- **Container Name**: `cyberlab_skf_js_sqli`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8783
[cyberlab_skf_js_sqli] (blabla1337/owasp-skf-lab:js-sqli)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_js_sqli
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8783/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=HM3Z-I998b4
