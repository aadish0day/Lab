# Lab Target: SKF_SESSION_HIJACK

## Overview
- **Vulnerability**: OWASP-SKF Session Hijacking XSS Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8713
- **Container Name**: `cyberlab_skf_session_hijack`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8713
[cyberlab_skf_session_hijack] (blabla1337/owasp-skf-lab:session-hijacking-xss)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_session_hijack
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8713/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Hv8H7ZgNdi4
