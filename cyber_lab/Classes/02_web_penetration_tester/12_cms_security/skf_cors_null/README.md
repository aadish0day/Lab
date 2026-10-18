# Lab Target: SKF_CORS_NULL

## Overview

- **Vulnerability**: OWASP-SKF Insecure Null Origin CORS Bypass Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8818
- **Container Name**: `cyberlab_skf_cors_null`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8818
[cyberlab_skf_cors_null] (blabla1337/owasp-skf-lab:cors-null)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_cors_null
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8818/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=q9F_xIi0Xzo
