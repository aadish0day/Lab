# Lab Target: JBOSS CVE-2017-7504

## Overview
- **Vulnerability**: CVE-2017-7504
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8598
- **Container Name**: `cyberlab_jboss_cve_2017_7504`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8598
[cyberlab_jboss_cve_2017_7504] (vulhub/jboss:as-4.0.5)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/jboss_cve_2017_7504
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8598/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['Wcd1Lskvj4c', 'Manipulating WebSocket messages with Burp Suite']
