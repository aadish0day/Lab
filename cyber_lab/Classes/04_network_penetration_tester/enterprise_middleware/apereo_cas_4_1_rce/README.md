# Lab Target: APEREO-CAS 4.1-RCE

## Overview
- **Vulnerability**: 4.1-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8650
- **Container Name**: `cyberlab_apereo_cas_4_1_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8650
[cyberlab_apereo_cas_4_1_rce] (vulhub/apereo-cas:4.1.5)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/apereo_cas_4_1_rce
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8650/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=IO4FjTflU6s
