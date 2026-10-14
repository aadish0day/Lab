# Lab Target: SKF_XXE_BLIND

## Overview
- **Vulnerability**: OWASP-SKF Blind XML External Entity Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8834
- **Container Name**: `cyberlab_skf_xxe_blind`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8834
[cyberlab_skf_xxe_blind] (blabla1337/owasp-skf-lab:xxe-blind)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_xxe_blind
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8834/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=2jVNXLMYEqM
