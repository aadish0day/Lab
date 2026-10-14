# Lab Target: SKF_CMD2

## Overview
- **Vulnerability**: OWASP-SKF Command Injection v2 Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8681
- **Container Name**: `cyberlab_skf_cmd2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8681
[cyberlab_skf_cmd2] (blabla1337/owasp-skf-lab:cmd2)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_cmd2
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8681/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=jC_aZB__dSE
