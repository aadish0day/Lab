# Lab Target: SKF_CMD_BLIND

## Overview
- **Vulnerability**: OWASP-SKF Blind Command Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8680
- **Container Name**: `cyberlab_skf_cmd_blind`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8680
[cyberlab_skf_cmd_blind] (blabla1337/owasp-skf-lab:cmd-blind)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_cmd_blind
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8680/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jcouSB4Q2wo
