# Lab Target: SKF_CLIENT_RESTRICTION_BYPASS

## Overview
- **Vulnerability**: OWASP-SKF Client-Side Restriction Bypass Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8699
- **Container Name**: `cyberlab_skf_client_restriction_bypass`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8699
[cyberlab_skf_client_restriction_bypass] (blabla1337/owasp-skf-lab:client-side-restriction-bypass)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_client_restriction_bypass
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8699/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=lDGbCxFVXwQ
