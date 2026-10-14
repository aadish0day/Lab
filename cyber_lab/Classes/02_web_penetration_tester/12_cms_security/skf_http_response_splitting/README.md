# Lab Target: SKF_HTTP_RESPONSE_SPLITTING

## Overview
- **Vulnerability**: OWASP-SKF Python HTTP Response Splitting Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8813
- **Container Name**: `cyberlab_skf_http_response_splitting`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8813
[cyberlab_skf_http_response_splitting] (blabla1337/owasp-skf-lab:http-response-splitting)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_http_response_splitting
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8813/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=lU_fu-B5QtI
