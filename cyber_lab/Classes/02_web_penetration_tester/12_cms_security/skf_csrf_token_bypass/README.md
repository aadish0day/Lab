# Lab Target: SKF_CSRF_TOKEN_BYPASS

## Overview

- **Vulnerability**: OWASP-SKF Anti-CSRF Token Bypass Vulnerability Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8817
- **Container Name**: `cyberlab_skf_csrf_token_bypass`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8817
[cyberlab_skf_csrf_token_bypass] (blabla1337/owasp-skf-lab:csrf-token-bypass)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_csrf_token_bypass
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8817/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=W4MXUnZB2jc
