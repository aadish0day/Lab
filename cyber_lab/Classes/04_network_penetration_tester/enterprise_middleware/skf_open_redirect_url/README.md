# Lab Target: SKF_OPEN_REDIRECT_URL

## Overview
- **Vulnerability**: OWASP-SKF Open URL Redirection Practice Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8847
- **Container Name**: `cyberlab_skf_open_redirect_url`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8847
[cyberlab_skf_open_redirect_url] (blabla1337/owasp-skf-lab:open-redirect-url)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_open_redirect_url
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8847/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=vwbUSHUYZnc
