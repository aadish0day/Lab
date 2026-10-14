# Lab Target: SKF_XXE_DOS

## Overview
- **Vulnerability**: OWASP-SKF XML Entity Expansion Billion Laughs DoS Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8835
- **Container Name**: `cyberlab_skf_xxe_dos`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8835
[cyberlab_skf_xxe_dos] (blabla1337/owasp-skf-lab:xxe-dos)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_xxe_dos
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8835/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=FUODIae2d98
