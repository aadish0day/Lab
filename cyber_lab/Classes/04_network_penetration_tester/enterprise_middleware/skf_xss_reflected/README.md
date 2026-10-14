# Lab Target: SKF_XSS_REFLECTED

## Overview
- **Vulnerability**: OWASP-SKF Reflected Cross-Site Scripting Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8836
- **Container Name**: `cyberlab_skf_xss_reflected`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8836
[cyberlab_skf_xss_reflected] (blabla1337/owasp-skf-lab:xss-reflected)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_xss_reflected
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8836/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=HtdGLZOuXXA
