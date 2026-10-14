# Lab Target: SKF_JAVA_XSS

## Overview
- **Vulnerability**: OWASP-SKF Cross-Site Scripting Practice Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8779
- **Container Name**: `cyberlab_skf_java_xss`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8779
[cyberlab_skf_java_xss] (blabla1337/owasp-skf-lab:xss)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_java_xss
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8779/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Jf3ZeL7lGog
