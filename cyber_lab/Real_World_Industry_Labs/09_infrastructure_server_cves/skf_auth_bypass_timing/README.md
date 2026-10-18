# Lab Target: SKF_AUTH_BYPASS_TIMING

## Overview

- **Vulnerability**: OWASP-SKF Timing Attack Side-Channel Auth Bypass
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8858
- **Container Name**: `cyberlab_skf_auth_bypass_timing`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8858
[cyberlab_skf_auth_bypass_timing] (blabla1337/owasp-skf-lab:auth-bypass-timing)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_auth_bypass_timing
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8858/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=sQ4TtFdaiRA
