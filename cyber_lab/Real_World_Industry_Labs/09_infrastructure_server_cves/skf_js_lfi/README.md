# Lab Target: SKF_JS_LFI

## Overview

- **Vulnerability**: OWASP-SKF Node.js Local File Inclusion Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8798
- **Container Name**: `cyberlab_skf_js_lfi`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8798
[cyberlab_skf_js_lfi] (blabla1337/owasp-skf-lab:js-lfi)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_js_lfi
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8798/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=sQ4TtFdaiRA
