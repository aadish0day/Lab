# Lab Target: SKF_CMD4

## Overview
- **Vulnerability**: OWASP-SKF Command Injection v4 Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8683
- **Container Name**: `cyberlab_skf_cmd4`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8683
[cyberlab_skf_cmd4] (blabla1337/owasp-skf-lab:cmd4)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_cmd4
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8683/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=gxID0acwBgc
