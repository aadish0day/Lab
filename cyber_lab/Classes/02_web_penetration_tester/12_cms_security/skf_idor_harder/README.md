# Lab Target: SKF_IDOR_HARDER

## Overview
- **Vulnerability**: OWASP-SKF Hardened IDOR Access Control Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8815
- **Container Name**: `cyberlab_skf_idor_harder`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8815
[cyberlab_skf_idor_harder] (blabla1337/owasp-skf-lab:idor-harder)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_idor_harder
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8815/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Ju3Wc6S0GhM
