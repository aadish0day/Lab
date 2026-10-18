# Lab Target: SKF_RATE_LIMITING_LOGIN

## Overview

- **Vulnerability**: OWASP-SKF Login Rate Limiting & Brute Force Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8845
- **Container Name**: `cyberlab_skf_rate_limiting_login`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8845
[cyberlab_skf_rate_limiting_login] (blabla1337/owasp-skf-lab:rate-limiting-login)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_rate_limiting_login
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8845/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=EpXabc1XdmM
