# Lab Target: SKF_CSRF_WEAK_ANTI_CSRF

## Overview
- **Vulnerability**: OWASP-SKF Weak Anti-CSRF Token Validation Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8816
- **Container Name**: `cyberlab_skf_csrf_weak_anti_csrf`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8816
[cyberlab_skf_csrf_weak_anti_csrf] (blabla1337/owasp-skf-lab:csrf-weak-anti-csrf-token)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_csrf_weak_anti_csrf
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8816/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=RYzbA72sbv8
