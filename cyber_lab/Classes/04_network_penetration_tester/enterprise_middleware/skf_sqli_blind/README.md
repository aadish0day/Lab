# Lab Target: SKF_SQLI_BLIND

## Overview
- **Vulnerability**: OWASP-SKF Boolean-Based Blind SQL Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8838
- **Container Name**: `cyberlab_skf_sqli_blind`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8838
[cyberlab_skf_sqli_blind] (blabla1337/owasp-skf-lab:sqli-blind)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_sqli_blind
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8838/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=4TJlREKMZMk
