# Lab Target: SKF_JWT_WEAK_HMAC

## Overview

- **Vulnerability**: OWASP-SKF Weak HMAC Secret JWT Cracking Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8850
- **Container Name**: `cyberlab_skf_jwt_weak_hmac`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8850
[cyberlab_skf_jwt_weak_hmac] (blabla1337/owasp-skf-lab:jwt-weak-hmac)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_jwt_weak_hmac
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8850/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=FvvdxA11-ZU
