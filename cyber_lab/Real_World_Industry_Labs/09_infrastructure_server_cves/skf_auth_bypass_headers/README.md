# Lab Target: SKF_AUTH_BYPASS_HEADERS

## Overview

- **Vulnerability**: OWASP-SKF Authentication Bypass via Custom HTTP Headers
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8857
- **Container Name**: `cyberlab_skf_auth_bypass_headers`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8857
[cyberlab_skf_auth_bypass_headers] (blabla1337/owasp-skf-lab:auth-bypass-headers)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_auth_bypass_headers
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8857/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=K5FdAVVeeb8
