# Lab Target: SKF_CORS_TRUST_ALL

## Overview

- **Vulnerability**: OWASP-SKF Wildcard Subdomain CORS Trust Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8819
- **Container Name**: `cyberlab_skf_cors_trust_all`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8819
[cyberlab_skf_cors_trust_all] (blabla1337/owasp-skf-lab:cors-trust-all-subdomains)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_cors_trust_all
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8819/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=lDGbCxFVXwQ
