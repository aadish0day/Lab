# Lab Target: VULHUB_WEBLOGIC_WEAK_PASSWORD

## Overview

- **Vulnerability**: Oracle WebLogic Console Weak Password Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8770
- **Container Name**: `cyberlab_vulhub_weblogic_weak_password`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8770
[cyberlab_vulhub_weblogic_weak_password] (vulhub/weblogic:10.3.6.0)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_weblogic_weak_password
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8770/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=CxBI2RRg-Mk
