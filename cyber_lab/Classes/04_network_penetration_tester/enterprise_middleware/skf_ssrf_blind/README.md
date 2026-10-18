# Lab Target: SKF_SSRF_BLIND

## Overview

- **Vulnerability**: OWASP-SKF Blind Server-Side Request Forgery Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8840
- **Container Name**: `cyberlab_skf_ssrf_blind`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8840
[cyberlab_skf_ssrf_blind] (blabla1337/owasp-skf-lab:ssrf-blind)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_ssrf_blind
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8840/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=F8K99Sn_dsM
