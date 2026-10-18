# Lab Target: THINKPHP 2-RCE

## Overview

- **Vulnerability**: 2-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8561
- **Container Name**: `cyberlab_thinkphp_2_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8561
[cyberlab_thinkphp_2_rce] (vulhub/thinkphp:2.1)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/thinkphp_2_rce
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8561/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['Opdq8YPRLBQ', 'HashiCorp Vault Policy - Part 7 | HashiCorp Vault tutorials']
