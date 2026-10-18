# Lab Target: SKF_JS_LFI_2

## Overview

- **Vulnerability**: OWASP-SKF Node.js LFI with Extension Truncation
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8801
- **Container Name**: `cyberlab_skf_js_lfi_2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8801
[cyberlab_skf_js_lfi_2] (blabla1337/owasp-skf-lab:js-lfi-2)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_lfi_2
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8801/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jC_aZB__dSE
