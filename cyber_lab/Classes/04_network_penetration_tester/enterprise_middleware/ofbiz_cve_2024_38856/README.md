# Lab Target: OFBIZ CVE-2024-38856

## Overview
- **Vulnerability**: CVE-2024-38856
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8590
- **Container Name**: `cyberlab_ofbiz_cve_2024_38856`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8590
[cyberlab_ofbiz_cve_2024_38856] (vulhub/ofbiz:18.12.14)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve_2024_38856
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8590/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['U1nMgb8AEB4', 'Kerberos Attacks Explained: User Enumeration, Kerberoasting and AS-REP Roasting']
