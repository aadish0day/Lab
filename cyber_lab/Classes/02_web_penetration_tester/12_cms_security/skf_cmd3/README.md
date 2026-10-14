# Lab Target: SKF_CMD3

## Overview
- **Vulnerability**: OWASP-SKF Command Injection v3 Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8682
- **Container Name**: `cyberlab_skf_cmd3`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8682
[cyberlab_skf_cmd3] (blabla1337/owasp-skf-lab:cmd3)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_cmd3
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8682/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=33VZ7RvMkgM
