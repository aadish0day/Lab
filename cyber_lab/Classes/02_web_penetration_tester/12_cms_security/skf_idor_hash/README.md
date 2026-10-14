# Lab Target: SKF_IDOR_HASH

## Overview
- **Vulnerability**: OWASP-SKF Predictable Hash IDOR Vulnerability Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8814
- **Container Name**: `cyberlab_skf_idor_hash`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8814
[cyberlab_skf_idor_hash] (blabla1337/owasp-skf-lab:idor-hash)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_idor_hash
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8814/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=cPUVsX9qmA8
