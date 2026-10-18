# Lab Target: SKF_JS_CMD

## Overview

- **Vulnerability**: OWASP-SKF Node.js Command Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8684
- **Container Name**: `cyberlab_skf_js_cmd`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8684
[cyberlab_skf_js_cmd] (blabla1337/owasp-skf-lab:js-cmd)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_cmd
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8684/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=dff4SROag0w
