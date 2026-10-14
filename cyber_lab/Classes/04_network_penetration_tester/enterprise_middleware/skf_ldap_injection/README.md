# Lab Target: SKF_LDAP_INJECTION

## Overview
- **Vulnerability**: OWASP-SKF LDAP Injection Vulnerability Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8831
- **Container Name**: `cyberlab_skf_ldap_injection`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8831
[cyberlab_skf_ldap_injection] (blabla1337/owasp-skf-lab:ldap-injection)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_ldap_injection
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8831/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=RC30YCI0c4I
