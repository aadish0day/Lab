# Lab Target: SKF_SSTI_JINJA2

## Overview
- **Vulnerability**: OWASP-SKF Jinja2 Server-Side Template Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8842
- **Container Name**: `cyberlab_skf_ssti_jinja2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8842
[cyberlab_skf_ssti_jinja2] (blabla1337/owasp-skf-lab:ssti-jinja2)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_ssti_jinja2
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8842/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=1dDvEmlLpWE
