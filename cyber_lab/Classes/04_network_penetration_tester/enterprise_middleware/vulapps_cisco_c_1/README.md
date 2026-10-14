# Lab Target: VULAPPS_CISCO_C_1

## Overview
- **Vulnerability**: Cisco ASA WebVPN Traversal & Authentication Bypass
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8718
- **Container Name**: `cyberlab_vulapps_cisco_c_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8718
[cyberlab_vulapps_cisco_c_1] (medicean/vulapps:c_cisco_1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_cisco_c_1
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8718/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=4TJlREKMZMk
