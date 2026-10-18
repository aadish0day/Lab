# Lab Target: SKF_SSTI_MAKO

## Overview

- **Vulnerability**: OWASP-SKF Mako Server-Side Template Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8843
- **Container Name**: `cyberlab_skf_ssti_mako`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8843
[cyberlab_skf_ssti_mako] (blabla1337/owasp-skf-lab:ssti-mako)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_ssti_mako
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8843/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=HM3Z-I998b4
