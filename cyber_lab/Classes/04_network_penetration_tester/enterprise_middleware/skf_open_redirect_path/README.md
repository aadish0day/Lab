# Lab Target: SKF_OPEN_REDIRECT_PATH

## Overview
- **Vulnerability**: OWASP-SKF Path-Based Open Redirect Practice Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8848
- **Container Name**: `cyberlab_skf_open_redirect_path`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8848
[cyberlab_skf_open_redirect_path] (blabla1337/owasp-skf-lab:open-redirect-path)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_open_redirect_path
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8848/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=-2_EUSTcfx4
