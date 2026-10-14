# Lab Target: KKFILEVIEW 4.3-ZIPSLIP-RCE

## Overview
- **Vulnerability**: 4.3-ZIPSLIP-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8595
- **Container Name**: `cyberlab_kkfileview_4_3_zipslip_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8595
[cyberlab_kkfileview_4_3_zipslip_rce] (vulhub/kkfileview:4.3.0)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/kkfileview_4_3_zipslip_rce
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8595/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['W4MXUnZB2jc', 'Broken Authentication and SQL Injection | OWASP Juice Shop TryHackMe']
