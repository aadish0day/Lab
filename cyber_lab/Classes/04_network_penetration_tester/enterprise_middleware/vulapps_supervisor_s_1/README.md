# Lab Target: VULAPPS_SUPERVISOR_S_1

## Overview
- **Vulnerability**: Supervisor XML-RPC Authenticated RCE Target (CVE-2017-11610)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8716
- **Container Name**: `cyberlab_vulapps_supervisor_s_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8716
[cyberlab_vulapps_supervisor_s_1] (medicean/vulapps:s_supervisor_1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_supervisor_s_1
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8716/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=HtdGLZOuXXA
