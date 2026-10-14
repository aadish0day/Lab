# Lab Target: SKF_JS_LDAP_INJECTION

## Overview
- **Vulnerability**: OWASP-SKF Node.js LDAP Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8789
- **Container Name**: `cyberlab_skf_js_ldap_injection`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8789
[cyberlab_skf_js_ldap_injection] (blabla1337/owasp-skf-lab:js-ldap-injection)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_js_ldap_injection
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8789/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=1OvVwZgqnlo
