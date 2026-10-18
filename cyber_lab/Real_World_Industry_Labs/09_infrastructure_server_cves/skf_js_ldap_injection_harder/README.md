# Lab Target: SKF_JS_LDAP_INJECTION_HARDER

## Overview

- **Vulnerability**: OWASP-SKF Node.js Filtered LDAP Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8797
- **Container Name**: `cyberlab_skf_js_ldap_injection_harder`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8797
[cyberlab_skf_js_ldap_injection_harder] (blabla1337/owasp-skf-lab:js-ldap-injection-harder)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_js_ldap_injection_harder
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8797/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=K5FdAVVeeb8
