# Lab Target: SKF_JS_FILE_UPLOAD

## Overview

- **Vulnerability**: OWASP-SKF Node.js Unrestricted File Upload Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8800
- **Container Name**: `cyberlab_skf_js_file_upload`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8800
[cyberlab_skf_js_file_upload] (blabla1337/owasp-skf-lab:js-file-upload)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_file_upload
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8800/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jcouSB4Q2wo
